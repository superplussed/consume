class JobListingWorker
  include Sidekiq::Worker

  def perform id
    Scraper::Craigslist::JobListing.new(id: id).scrape
  end
end