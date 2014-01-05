class AddSkipToCities < ActiveRecord::Migration
  def change
    add_column :cities, :skip, :boolean, default: false
  end
end
