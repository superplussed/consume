class ChangePostedAtToDateTime < ActiveRecord::Migration
  def change
    change_column :job_listings, :posted_at, :datetime
  end
end
