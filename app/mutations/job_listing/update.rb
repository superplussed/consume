class JobListing::Update < Mutations::Command

  required do
    string :url
  end

  optional do
    string :title
    boolean :remote
    datetime :date
  end

  def execute
    JobListing.find_by_url(url).set(
      title: title,
      remote: remote,
      date: date
    )
  end
end
