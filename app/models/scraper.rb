class Scraper

  CATEGORY_URLS = ["eng", "sof", "web"]

  def cities
    doc = Document.new("http://www.craigslist.org/about/sites")
    country_list = doc.root.css("h1").map{|country| country.text()}
    doc.root.css(".colmask").each_with_index do |colmask, i|
      colmask.css(".box").each do |box|
        country = country_list[i].to_s
        state_list = box.css("h4").map{|state| state.text()}
        box.css("ul").each_with_index do |ul, i|
          state = state_list[i].to_s
          ul.css("li").each do |li|
            a = li.css("a")
            name = a.text().to_s
            match = a.attribute("href").to_s.match("http:\/\/(.*).craigslist")
            subdomain = match[1] if match
            unless City.find_by_name_and_state_and_country(name, state, country)
              City.create(subdomain: subdomain, name: name, state: state, country: country)
            end
          end
        end
      end
    end
  end

  def job_listing_urls subdomain="newyork", from=1.month.ago, to=Time.now, remote=true
    if city = City.find_by_subdomain(subdomain)
      CATEGORY_URLS.each do |category|
        if remote
          url = "https://#{subdomain}.craigslist.org/search/#{category}?addOne=telecommuting"
        else
          url = "https://#{subdomain}.craigslist.org/#{category}"
        end
        doc = Document.new(url).root
        doc.css(".row").each do |row|
          pl = row.css(".pl")
          date = pl.css(".date").text().to_s
          date = Chronic.parse("#{date} 2013")
          a = pl.css("a")
          url = a.attribute("href").to_s
          title = a.text().to_s
          unless JobListing.find_by_url(url)
            city.job_listings.push(url: url, title: title, remote: remote, date: date)
          end
        end
      end
    end

  end

end