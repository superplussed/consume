class Consumer::JobListing
  include Parser, Attrio, MassAssignment

  define_attributes do 
    attr :id, Integer
    attr :url, String
  end

  def scrape 
    query.each do |job_listing|
      if document = get_document(job_listing, job_listing.absolute_url)
        res = JobListing::Update.run(
          id: job_listing.id,
          body: body(document),
          email: email(document),
          compensation: compensation(document),
          posted_at: date(document),
          craigslist_id: craigslist_id(document)
        )
        job_listing.error_logs.push(message: res.errors.message_list.join(", ")) unless res.success?
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
    el = doc.css(".dateReplyBar a") unless el
    tag = parse_a_tag(el)
    tag[:href] if tag
  end

  def body doc
    body = doc.css('#postingbody').to_html()
    body = doc.css(".userbody").to_html() unless (body && body.length > 0)
    Encoding::Converter.new("iso-8859-1", "utf-8").convert(body)
  end

  def compensation doc
    doc.css(".blurbs li").each do |blurb|
      match = blurb.text().to_s.strip.match("Compensation:(.*)")
      return match[1].strip if match
    end
    nil
  end

  def date doc
    if el = doc.css("time")[0]
      date_str = el.attribute("datetime").to_s
    elsif el = doc.css("date")[0]
      date_str = strip_time_zone(el.text().to_s)
    end
    Chronic.parse(date_str.squish).to_s if date_str
  end

  def strip_time_zone str
    ["EST", "EDT", "MDT", "PDT", "CST"].each do |tz|
      str = str.gsub(tz, "")
    end
    str
  end
end