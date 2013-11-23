class ChangeEmailToText < ActiveRecord::Migration
  def change
    change_column :job_listings, :email, :text
  end
end
