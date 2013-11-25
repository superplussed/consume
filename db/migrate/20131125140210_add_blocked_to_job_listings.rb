class AddBlockedToJobListings < ActiveRecord::Migration
  def change
    add_column :job_listings, :duplicate, :boolean, default: false
    add_index :job_listings, :duplicate
  end
end
