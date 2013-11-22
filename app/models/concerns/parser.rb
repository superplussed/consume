module Parser
  extend ActiveSupport::Concern
  
  def parse_a_tag el
    a_tag = el.css("a")
    {
      href: a_tag.attribute("href").to_s,
      text: a_tag.text().to_s
    }
  end

  def match str, regex
    res = str.match(regex)
    res[1] if res
  end

  def document
    Scraper::Document.new(url).root if url
  end

end