module CityList

  def self.scrape
    Scraper::Craigslist::CityList.new.scrape
  end

  def self.next_in_queue
    if City.where(country: 'US', last_scrape_ended_at: nil).exists?
      City.where(country: 'US', last_scrape_ended_at: nil).first
    else
      City.where(country: 'US').order(:last_scrape_ended_at).first
    end
  end

end 