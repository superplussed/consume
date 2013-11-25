class CreateTableErrorLog < ActiveRecord::Migration
  def change
    create_table :error_logs do |t|
      t.text :message

      t.timestamps
    end

    create_table :error_log_associations do |t|
      t.integer :error_log_id
      t.integer :target_id

      t.timestamps
    end
    add_index :error_log_associations, [:error_log_id, :target_id]
  end

  remove_column :cities, :error
  remove_column :cities, :error_message
  remove_column :job_listings, :error
  remove_column :job_listings, :error_message
end
