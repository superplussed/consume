class JobListing::Update < Mutations::Command

  required do
    integer :id
    string :posted_at
    string :body
  end

  optional do
    string :url
    string :email
    string :compensation
    string :title
    boolean :remote
    date :date
  end

  def execute
    self.posted_at = self.posted_at.to_time
    JobListing.find(id).update_attributes(inputs)
  end
end
