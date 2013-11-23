class Scraper::Craigslist::JobListing
  include Parser, Attrio, MassAssignment

  define_attributes do 
    attr :url, String
  end

  def scrape 
    query.each do |job_listing|
      @url = job_listing.absolute_url
      doc = document
      JobListing::Update.run!(
        id: job_listing._id.to_s,
        body: body(doc),
        email: email(doc),
        compensation: compensation(doc),
        posted_at: date(doc),
        craigslist_id: craigslist_id(doc)
      )
    end
  end

private

  def query 
    if url.present?
      [JobListing.find_by_url(url.match(".*.org(.*)")[1])]
    else
      JobListing.where(body: nil).limit(1)
    end
  end

  def craigslist_id doc
    doc.css("input[name=postingID]").attribute("value")
  end

  def email doc
    el = doc.css(".returnemail")
    tag[:href] if el.present? && tag = parse_a_tag(el)
  end

  def body doc
    doc.css(".userbody").to_s
  end

  def compensation doc
    blurbs = doc.css(".blurbs li")
    compensation = blurbs[1].text().to_s
  end

  def date doc
    if date_tag = doc.css("time")[0]
      Chronic.parse(date_tag.attribute("datetime").to_s).to_s
    end
  end

end