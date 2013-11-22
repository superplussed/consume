require 'nokogiri'
require 'open-uri'
require 'openssl'

class Document
  attr_accessor :link, :path, :root

  def initialize path
    @path = path
    @link = Link.new(path) unless path[0] == "/"
    @root = fetch_document
  end

private

  def fetch_document
    if link && link.secure?
      get_remote_secure
    elsif link
      get_remote
    else
      get_local
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
