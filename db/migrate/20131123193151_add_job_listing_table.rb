class AddJobListingTable < ActiveRecord::Migration
  def change
    create_table :job_listings do |t|
      t.string :title
      t.string :url
      t.text :body
      t.string :email
      t.boolean :remote
      t.date :posted_at
      t.string :compensation
      t.string :craigslist_id
      t.integer :city_id

      t.timestamps
    end
    add_index :job_listings, [:city_id, :posted_at]
  end
end
