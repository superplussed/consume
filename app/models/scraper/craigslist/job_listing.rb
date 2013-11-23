class Scraper::Craigslist::JobListing
  include Parser, Attrio, MassAssignment

  define_attributes do 
    attr :id, Integer
    attr :url, String
  end

  def scrape 
    if document && !document.error
      query.each do |job_listing|
        @url = job_listing.absolute_url
        doc = document
        ::JobListing::Update.run!(
          id: job_listing.id,
          body: body(doc),
          email: email(doc),
          compensation: compensation(doc),
          posted_at: date(doc),
          craigslist_id: craigslist_id(doc)
        )
      end
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
    if date_tag = doc.css("time")[0]
      Chronic.parse(date_tag.attribute("datetime").to_s).to_s
    end
  end

end