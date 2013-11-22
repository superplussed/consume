require 'net/http'

class Link
  attr_accessor :uri, :url

  delegate :path, to: :uri
  delegate :scheme, to: :uri

  def initialize url
    @url = url
    if normalized_url = normalize_url(@url)
      @url = normalized_url
    end
    @url = get_redirected_url(@url) unless local?
    @uri = URI(@url)
  end

  def secure?
    !local? && uri.scheme == 'https'
  end

  def local?
    url[0] == "/"
  end

  def get_redirected_url(url, limit = 10)
    unless limit == 0
      response = Net::HTTP.get_response(URI(url))
      if[Net::HTTPRedirection, Net::HTTPMovedPermanently].include?(response.class)
        get_redirected_url(response['location'], limit - 1)
      else
        url
      end
    end
  end

  def last_path_fragment
    match = path.match(/.*\/(.*)/)
    match[1] if match
  end

  def host
    if !local?
      uri.port == 8080 ? "#{uri.host}:#{uri.port}" : uri.host
    end
  end

  def name
    uri.host ? uri.host.gsub("www.", "") : last_path_fragment
  end

  def page
    if path.blank?
       "/"
    elsif local?
      "/#{last_path_fragment}"
    else
      path
    end
  end

  def root
    local? ? url.match(/(.*)\//)[1] : "#{uri.scheme}://#{host}"
  end

  def root_name
    if local?
      ary = url.split("/")
      ary[ary.length-2] if ary.length-2 > 0
    else
      host
    end
  end

  def full
    "#{root}#{path}"
  end

  def normalize_url url
    url[0..3] == "http" ? url : ('http://' << url) unless url.blank? || local?
  end
end