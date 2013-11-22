class City
  include MongoMapper::Document

  key :subdomain
  key :name
  key :state
  key :country

  many :job_listings

  def absolute_url
    "https://#{subdomain}.craigslist.org"
  end

end