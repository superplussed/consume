class JobListing
  include MongoMapper::Document

  key :title
  key :url
  key :body
  key :email
  key :remote, Boolean
  key :date
  key :compensation
  key :craigslist_id

  belongs_to :city

  def self.scrape
    Scraper::Craigslist::JobListingList.new({}).scrape
  end

  def self.update_scrapes
    Scraper::Craigslist::JobListing.new({}).scrape
  end

  def scrape
    Scraper::Craigslist::JobListing.new({id: self.id.to_s}).scrape
  end

  def absolute_url
    "#{city.absolute_url}#{url}"
  end
end