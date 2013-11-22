module Parser
  extend ActiveSupport::Concern
  
  def parse_a_tag el
    {
      href: el.attribute("href").to_s,
      text: el.text().to_s
    }
  end

  def match str, regex
    res = str.match(regex)
    res[1] if res
  end

end