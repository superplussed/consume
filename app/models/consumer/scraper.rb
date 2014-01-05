class Consumer::Scraper

  def cities_list
    Consumer::CityList.new.scrape
  end

  def job_listings
    City.where(skip: false).order(:last_scrape_ended_at).each do |city|
      city.scrape
      sleep(Settings.seconds_between_job_list_scrapes)
    end
  end

  def retry
    JobListing.where(error: true).each do |job_listing|
      job_listing.scrape
      sleep(Settings.seconds_between_job_list_scrapes)
    end
  end
end