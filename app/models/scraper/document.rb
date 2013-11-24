require 'nokogiri'
require 'open-uri'
require 'openssl'


class Scraper::Document
  include Attrio

  define_attributes do
    attr :path, String
    attr :error, String
    attr :root, Nokogiri::HTML
    attr :link, Scraper::Link
  end

  def initialize path
    @link = Scraper::Link.new(path)
    if link.error
      @error = link.error
    else
      @path = path
      @root = fetch_document 
    end
  end

private

  def fetch_document
    if link.secure?
      get_remote_secure
    elsif path[0] == "/"
      get_local
    else
      get_remote
    end
  end

  def get_remote_secure
    file = open(URI.parse(link.full),:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE, :allow_redirections => :all)
    Nokogiri::HTML(file, nil, 'utf-8')
  end

  def get_remote
    Nokogiri.HTML(Net::HTTP.get(URI.parse(link.full)), nil, 'utf-8')
  end

  def get_local
    Nokogiri.HTML(File.open(path), nil, 'utf-8')
  end
end
