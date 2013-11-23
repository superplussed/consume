class AddCityTable < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :subdomain
      t.string :name
      t.string :state
      t.string :country
      t.date :last_scraped_at

      t.timestamps
    end
  end
end
