class JobListing
  include MongoMapper::Document

  key :title
  key :url
  key :body
  key :email
  key :remote, Boolean
  key :date
  key :compensation
  key :cl_id

  belongs_to :city

  def self.scrape_all from=1.month.ago, to=Time.now
    City.find_all_by_country("US").each do |city|
      url = city.url
      p url
    end
  end

  def self.scrape_listings
    JobListing.where(body: nil).each do |listing|
      doc = Document.new(listing.absolute_url).root
      body = doc.css(".postingbody").to_s
      body = doc.css(".userbody").to_s if body.blank?
      a = doc.css(".replylink")
      email = a.attribute("href").to_s unless a.blank?
      blurbs = doc.css(".blurbs li")
      compensation = blurbs[1].text().to_s
      p "email: #{email} compensation: #{compensation}"
      listing.set(body: body, compensation: compensation, email: email)
    end

  end

  def absolute_url
    "#{city.url}#{url}"
  end
end