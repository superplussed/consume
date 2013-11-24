class AddErrorFieldToJobListing < ActiveRecord::Migration
  def change
    add_column :job_listings, :error, :boolean, default: false
    add_column :job_listings, :error_message, :string
    add_index :job_listings, :error
  end
end
