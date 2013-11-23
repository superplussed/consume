class JobListing::Create < Mutations::Command

  required do
    model :city
    string :url
    string :title
    boolean :remote
  end

  def execute
    unless JobListing.where(url: url).exists?
      city.job_listings.create(inputs)
    end
  end
end
