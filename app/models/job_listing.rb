class JobListing < ActiveRecord::Base

  belongs_to :city

  scope :for_display, where("error = false AND body IS NOT NULL")

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
    if url[0] == "/"
      "#{city.absolute_url}#{url}"
    else
      url
    end
  end
end