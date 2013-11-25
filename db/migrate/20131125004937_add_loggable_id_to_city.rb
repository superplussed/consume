class AddLoggableIdToCity < ActiveRecord::Migration
  def change
    add_column :cities, :loggable_id, :integer
    add_column :job_listings, :loggable_id, :integer
  end
end
