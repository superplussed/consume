class JobListing
  include MongoMapper::Document

  key :title
  key :url
  key :body
  key :email
  key :remote, Boolean
  key :date
  key :compensation
  key :cl_id

  belongs_to :city

  def absolute_url
    "#{city.url}#{url}"
  end
end