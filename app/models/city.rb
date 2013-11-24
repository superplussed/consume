class City < ActiveRecord::Base
  extend AdminConfig::City

  has_many :job_listings

  admin_block.call(rails_admin)

  def scrape_job_listings
    self.update_attributes(last_scraped_started_at: Time.now)
    Scraper::Craigslist::JobListingList.new(subdomain: self.subdomain).scrape
    self.update_attributes(last_scraped_ended_at: Time.now)
  end

  def absolute_url
    "https://#{subdomain}.craigslist.org"
  end

end