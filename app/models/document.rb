require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
require 'openssl'

class Document
  include Attrio

  define_attributes do
    attr :path, String
    attr :error, String
    attr :root, Nokogiri::HTML
    attr :link, Link
  end

  def initialize path
    @link = Link.new(path)
    if link.error
      @error = link.error
    else
      @path = path
      @root = Nokogiri.HTML(fetch_file, nil, 'utf-8') 
    end
  end

private

  def fetch_file
    if link.local?
      File.open(path)
    elsif link.secure?
      open(URI.parse(link.full), :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE, :allow_redirections => :all)
    else
      Net::HTTP.get(URI.parse(link.full))
    end
  end
  
end
