class JobListing < ActiveRecord::Base
  extend AdminConfig::JobListing

  belongs_to :city
  attr_accessible :id, :city, :url, :title, :remote, :error, :error_message, :body, :email, :compensation, :posted_at, :craigslist_id

  scope :for_display, -> { where("error = false AND body IS NOT NULL") }

  admin_block.call(rails_admin)

  def absolute_url
    if url && url[0] == "/" && !url.match('/Users')
      "#{city.absolute_url}#{url}"
    else
      url
    end
  end

  def scrape
    Consumer::JobListing.new({id: self.id.to_s}).scrape
  end
end