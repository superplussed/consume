class Scraper::Craigslist::JobListing
  include Attrio, MassAssignment, Parser

  CATEGORIES = ["eng", "sof", "web"]

  define_attributes do
    attr :url, String
    attr :subdomain, String, default: "newyork"
    attr :from, DateTime, default: 1.month.ago
    attr :to, DateTime, default: Time.now
    attr :remote, Boolean, default: true
  end

  def scrape
    JobListing.where(body: nil).each do |listing|
      doc = Document.new(listing.absolute_url)
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