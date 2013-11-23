class JobListing < ActiveRecord::Base

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