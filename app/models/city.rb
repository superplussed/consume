class City < ActiveRecord::Base

  has_many :job_listings

  def self.scrape
    Scraper::Craigslist::CityList.new.scrape
  end

  def self.next
    City.where(country: 'US').sort(:last_scraped_at.desc)
  end

  def absolute_url
    "https://#{subdomain}.craigslist.org"
  end
end