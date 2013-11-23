class City < ActiveRecord::Base

  has_many :job_listings

  def scrape_job_listings
    Scraper::Craigslist::JobListingList.new(subdomain: self.subdomain).scrape
    self.update_attributes(last_scraped_at: Time.now)
  end

  def absolute_url
    "https://#{subdomain}.craigslist.org"
  end

end