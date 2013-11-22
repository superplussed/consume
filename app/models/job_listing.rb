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


  def self.scrape
    Scraper::Craigslist::JobListingList.new.scrape
  end

  def absolute_url
    "#{city.absolute_url}#{url}"
  end
end