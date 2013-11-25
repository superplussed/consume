module FileHelper

  CURRENT_FOLDER = "11-24-2013"

  def self.create_url page_name
    "#{Rails.root}/spec/pages/craigslist/#{CURRENT_FOLDER}/#{page_name}.html"
  end
end