class AddErrorToCities < ActiveRecord::Migration
  def change
    add_column :cities, :error, :boolean, default: false
    add_column :cities, :error_message, :text
  end
end
