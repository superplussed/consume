class Scraper::Craigslist::CityList
  include Parser

  def scrape
    document.css(".colmask").each_with_index do |col, col_index|
      col.css(".box").each do |box|
        box.css("ul").each_with_index do |ul, ul_index|
          ul.css("li").each do |li|
            a_tag = parse_a_tag(li)
            City::Create.run!(
              subdomain: match(a_tag[:href], "http:\/\/(.*).craigslist"), 
              name: a_tag[:text], 
              state: states(box)[ul_index].to_s, 
              country: countries[col_index].to_s
            )
          end
        end
      end
    end
  end

private

  def url
    "http://www.craigslist.org/about/sites"
  end

  def countries
    @countries ||= document.css("h1").map{|country| country.text().to_s}
  end

  def states el
    @states ||= el.css("h4").map{|state| state.text().to_s}
  end
end