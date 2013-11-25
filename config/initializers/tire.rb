Tire.configure do
  if Rails.env == "development" || Rails.env == "test" 
    url "http://localhost:9200/"
    #url "http://es.3rdward.com:9200"
  else
    url "http://c.onsu.me:9200"
  end
end