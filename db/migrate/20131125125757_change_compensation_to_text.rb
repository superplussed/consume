class ChangeCompensationToText < ActiveRecord::Migration
  def change
    change_column :job_listings, :compensation, :text
  end
end
