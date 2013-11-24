class Consumer::JobList
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
    urls.each do |url|
      if document = get_document(url)
        document.css(".row").each do |row|
          pl = row.css(".pl")
          a_tag = parse_a_tag(pl)
          ::JobListing::Create.run!(
            city: city,
            url: a_tag[:href], 
            title: a_tag[:text], 
            remote: remote
          )
        end
      else
        city.update_attributes(error: true)
      end
    end
  end

  def urls
    @url.present? ? [@url] : create_urls
  end

private

  def create_urls
    ary = []
    CATEGORIES.each do |category|
      if remote
        ary.push("#{city.absolute_url}/search/#{category}?addOne=telecommuting")
      else
        ary.push("#{city.absolute_url}/#{category}")
      end
    end
    ary
  end

  def city
    @city ||= City.where(subdomain: subdomain).first
  end
end