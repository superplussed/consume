class JobListingWorker
  include Sidekiq::Worker

  def perform id
    Scraper::JobListing.new(id: id).scrape
  end
end