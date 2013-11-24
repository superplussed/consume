class City < ActiveRecord::Base
  extend AdminConfig::City

  has_many :job_listings
  attr_accessible :updated_at, :created_at, :name, :abbrev, :state, :country, :last_scrape_started_at, :last_scrape_ended_at

  admin_block.call(rails_admin)

  def scrape_job_listings
    self.update_attributes(last_scrape_started_at: DateTime.now)
    Scraper::Craigslist::JobListingList.new(subdomain: self.subdomain).scrape
    self.update_attributes(last_scrape_ended_at: DateTime.now)
  end

  def absolute_url
    "https://#{subdomain}.craigslist.org"
  end

  def remote_urls
    ["eng", "sof", "web"].map do |category|
      "#{self.absolute_url}/search/#{category}?addOne=telecommuting"
    end.join(",")
  end

end