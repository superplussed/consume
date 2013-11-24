class JobListing < ActiveRecord::Base
  extend AdminConfig::JobListing

  belongs_to :city
  attr_accessible :id, :city, :url, :title, :remote, :error, :error_message, :body, :email, :compensation, :posted_at, :craigslist_id

  scope :for_display, where("error = false AND body IS NOT NULL")

  admin_block.call(rails_admin)

  def self.scrape
    Scraper::JobList.new({}).scrape
  end

  def self.update_scrapes
    Scraper::JobListing.new({}).scrape
  end

  def self.scrape_errors
    JobListing.where(error: true).each do |job_listing|
      job_listing.scrape
      sleep (10.seconds)
    end
  end

  def scrape
    Scraper::JobListing.new({id: self.id.to_s}).scrape
  end

  def absolute_url
    if url && url[0] == "/"
      "#{city.absolute_url}#{url}"
    else
      url
    end
  end
end