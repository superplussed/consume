class JobListing::Create < Mutations::Command

  required do
    model :city
    string :url
    string :title
    boolean :remote
  end

  def execute
    unless JobListing.find_by_url(url)
      city.job_listings.push(inputs)
    end
  end
end
