module CityList

  def self.scrape
    Scraper::Craigslist::CityList.new.scrape
  end

  def self.next_in_queue
    City.where(country: 'US').order(:last_scraped_at).first
  end

end 