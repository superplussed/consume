module CityList

  def self.scrape
    Scraper::CityList.new.scrape
  end

  def self.scrape_all
    City.where(country: 'US', last_scrape_ended_at: nil).each do |city|
      city.scrape_job_listings
    end
  end

  def self.next_in_queue
    if City.where(country: 'US', last_scrape_ended_at: nil).exists?
      City.where(country: 'US', last_scrape_ended_at: nil).first
    else
      City.where(country: 'US').order(:last_scrape_ended_at).first
    end
  end

end 