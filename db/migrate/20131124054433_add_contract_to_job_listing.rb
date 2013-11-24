class AddContractToJobListing < ActiveRecord::Migration
  def change
    add_column :job_listings, :contract, :boolean, default: false
    add_column :job_listings, :part_time, :boolean, default: false
  end
end
