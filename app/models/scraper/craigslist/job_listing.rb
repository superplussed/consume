class Scraper::Craigslist::JobListing
  include Parser, Attrio, MassAssignment

  define_attributes do 
    attr :id, Integer
    attr :url, String
  end

  def scrape 
    query.each do |job_listing|
      @url = job_listing.absolute_url
      doc = document
      res = ::JobListing::Update.run(
        id: job_listing.id,
        body: body(doc),
        email: email(doc),
        compensation: compensation(doc),
        posted_at: date(doc),
        craigslist_id: craigslist_id(doc)
      )
      job_listing.update_attributes(error: true, error_message: res.errors.to_s) unless res.success?
    end
  end

private

  def query 
    if id.present?
      JobListing.where(id: id)
    else
      JobListing.where(body: nil)
    end
  end

  def craigslist_id doc
    el = doc.css("input[name=postingID]")
    el.attribute("value") if el.present?
  end

  def email doc
    el = doc.css(".replylink")
    if el.present?
      tag = parse_a_tag(el)
      tag[:href] if tag
    end
  end

  def body doc
    body = doc.css('#postingbody').to_s
    body.present? ? body : doc.css(".userbody").to_s
  end

  def compensation doc
    doc.css(".blurbs li").each do |blurb|
      match = blurb.text().to_s.strip.match("Compensation:(.*)")
      return match[1].strip if match
    end
    nil
  end

  def date doc
    if time_tag = doc.css("time")[0]
      date_str = time_tag.attribute("datetime").to_s
    elsif date_tag = doc.css("date")[0]
      date_str = date_tag.text().to_s
      date_str = date_str.gsub("EST", "").gsub("MST", "").gsub("PST", "").gsub("CMT", "")
    end
    Chronic.parse(date_str.squish).to_s if date_str
  end

end