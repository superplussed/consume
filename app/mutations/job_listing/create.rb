class JobListing::Create < Mutations::Command

  required do
    model :city
    string :url
    string :title
    boolean :remote
    time :date
  end

  def execute
    if JobListing.find_by_url(url)
      JobListing::Update.run!(
        city: city,
        url: url,
        title: title,
        remote: remote,
        date: date
      )
    else
      city.job_listings.push(
        url: url, 
        title: title, 
        remote: remote, 
        date: date
      )
    end
  end
end
