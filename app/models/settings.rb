class Settings < ActiveRecord::Base
  extend AdminConfig::Settings

  attr_accessible :rescrape_job_listings, :seconds_between_job_list_scrapes, :monitor_job_lists

  admin_block.call(rails_admin)
end