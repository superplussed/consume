class AddLoggableToErrorLog < ActiveRecord::Migration
  def change
    add_column :error_logs, :loggable_id, :integer
    add_column :error_logs, :loggable_type, :string
    drop_table :error_log_associations
  end
end
