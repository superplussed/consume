class AddRolesTables < ActiveRecord::Migration
  def change
    create_table "roles" do |t|
      t.string   "name"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "roles_users", :id => false do |t|
      t.integer "role_id"
      t.integer "user_id"
    end

    add_index "roles_users", ["role_id", "user_id"], :name => "ru_comp_1"
  end
end
