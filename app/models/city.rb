class City < ActiveRecord::Base
  extend AdminConfig::City

  has_many :job_listings
  has_many :error_logs, as: :loggable
  attr_accessible :skip, :subdomain, :updated_at, :created_at, :name, :abbrev, :state, :country, :last_scrape_started_at, :last_scrape_ended_at

  admin_block.call(rails_admin)

  def scrape
    self.update_attributes(last_scrape_started_at: DateTime.now)
    Consumer::JobList.new(subdomain: self.subdomain).scrape
    self.update_attributes(last_scrape_ended_at: DateTime.now)
  end

  def absolute_url
    "https://#{subdomain}.craigslist.org"
  end

  def urls
    Consumer::JobList.new({subdomain: subdomain}).urls
  end

end