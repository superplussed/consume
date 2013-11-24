class AddLastScrapeStartedAtCities < ActiveRecord::Migration
  def change
    add_column :cities, :last_scrape_started_at, :timestamp
    add_column :cities, :last_scrape_ended_at, :timestamp
  end
end
