class Consumer::Scraper

  def cities_list
    Consumer::CityList.new.scrape
  end

  def job_listings
    City.where(country: 'US', last_scrape_ended_at: nil).each do |city|
      city.scrape
      sleep(10.seconds)
    end
  end

  def retry
    JobListing.where(error: true).each do |job_listing|
      job_listing.scrape
      sleep(10.seconds)
    end
  end
end