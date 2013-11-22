require 'nokogiri'
require 'open-uri'
require 'openssl'

class Scraper::Document
  include Attrio

  define_attributes do
    attr :path, String
    attr :root, Nokogiri::HTML
  end

  def initialize path
    @path = path
    @root = fetch_document
  end

  def link
    @link ||= Scraper::Link.new(path)
  end

private

  def fetch_document
    if link && link.secure?
      get_remote_secure
    elsif path[0] == "/"
      get_local
    elsif link
      get_remote
    end
  end

  def get_remote_secure
    Nokogiri::HTML(open(URI.parse(link.full),:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
  end

  def get_remote
    Nokogiri.HTML(Net::HTTP.get(URI.parse(link.full)))
  end

  def get_local
    Nokogiri.HTML(File.open(path))
  end
end
