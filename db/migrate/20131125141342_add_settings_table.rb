class AddSettingsTable < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.boolean :rescrape_job_listings, default: false
      t.integer :seconds_between_job_list_scrapes, default: 10
      t.boolean :monitor_job_lists, default: false
    end
  end
end
