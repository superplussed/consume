class JobListingWorker
  include Sidekiq::Worker

  def perform id
    Consumer::JobListing.new(id: id).scrape
  end
end