class JobListing::Upsert < Mutations::Command

  required do
    model :city
    string :url
    string :title
    boolean :remote
  end

  optional do
    model :job_listing
  end

  def execute
    job_listing = JobListing.where(url: url).first
    exists = !!job_listing

    unless exists
      job_listing = city.job_listings.create(
        url: url,
        title: title,
        remote: remote
      ) 
    end
    
    if !exists || Settings.rescrape_job_listings
      JobListingWorker.perform_async(job_listing.id)
    end
  end
end
