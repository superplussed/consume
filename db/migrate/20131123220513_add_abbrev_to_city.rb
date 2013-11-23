class AddAbbrevToCity < ActiveRecord::Migration
  def change
    add_column :cities, :abbrev, :string
  end
end
