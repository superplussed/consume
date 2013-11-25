class RemoveLastScrapedAt < ActiveRecord::Migration
  def change
    remove_column :cities, :last_scraped_at
  end
end
