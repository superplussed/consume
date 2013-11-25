module Parser
  extend ActiveSupport::Concern
  
  def parse_a_tag el
    a_tag = el.css("a")
    if a_tag.present?
      {
        href: a_tag.attribute("href").to_s,
        text: a_tag.text().to_s
      }
    end
  end

  def match str, regex
    if res = str.match(regex)
      res[1] 
    end
  end

  def get_document(obj, url)
    begin
      Document.new(url).root if url.present?
    rescue Exception => e
      obj.error_logs.create(message: e.message) if obj
      nil
    end
  end

end