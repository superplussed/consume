class Scraper::Craigslist::JobListingList
  include Attrio, MassAssignment, Parser

  CATEGORIES = ["eng", "sof", "web"]

  define_attributes do
    attr :url, String
    attr :subdomain, String, default: "newyork"
    attr :from, DateTime, default: 1.month.ago
    attr :to, DateTime, default: Time.now
    attr :remote, Boolean, default: true
  end

  def scrape    
    CATEGORIES.each do |category|
      @url = create_url(category)
      document.css(".row").each do |row|
        pl = row.css(".pl")
        a_tag = parse_a_tag(pl)
        JobListing::Create.run!(
          city: city,
          url: a_tag[:href], 
          title: a_tag[:text], 
          remote: remote
        )
      end
    end
  end

private

  def create_url category
    if remote
       url = "#{city.absolute_url}/search/#{category}?addOne=telecommuting"
     else
       url = "#{city.absolute_url}/#{category}"
     end
  end

  def city
    City.find_by_subdomain(subdomain)
  end
end