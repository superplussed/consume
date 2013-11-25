class Consumer::CityList
  include Parser

  def scrape
    if document = get_document(nil, "http://www.craigslist.org/about/sites")
      document.css(".colmask").each_with_index do |col, col_index|
        col.css(".box").each do |box|
          box.css("ul").each_with_index do |ul, ul_index|
            ul.css("li").each do |li|
              country = countries(document)[col_index].to_s
              if country == 'US'
                a_tag = parse_a_tag(li)
                ::City::Create.run!(
                  subdomain: match(a_tag[:href], "http:\/\/(.*).craigslist"), 
                  name: a_tag[:text], 
                  state: states(box)[ul_index].to_s, 
                  country: country
                )
              end
            end
          end
        end
      end
    end
  end

private

  def countries el
    @countries ||= el.css("h1").map{|country| country.text().to_s}
  end

  def states el
    @states ||= el.css("h4").map{|state| state.text().to_s}
  end
end