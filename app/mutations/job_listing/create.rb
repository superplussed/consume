class JobListing::Create < Mutations::Command

  required do
    model :city
    string :url
    string :title
    boolean :remote
  end

  def execute
    unless JobListing.where(url: url).exists?
      job_listing = city.job_listings.create(inputs)
      JobListingWorker.perform_async(job_listing.id)
    end
  end
end
