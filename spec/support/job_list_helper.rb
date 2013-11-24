module JobListHelper

  def self.fetch page_name
    Consumer::JobList.new({url: FileHelper.create_url(page_name), subdomain: "newyork"})
  end
end