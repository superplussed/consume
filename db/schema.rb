# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131129172619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.string   "subdomain"
    t.string   "name"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbrev"
    t.datetime "last_scrape_started_at"
    t.datetime "last_scrape_ended_at"
    t.integer  "loggable_id"
    t.boolean  "skip",                   default: false
  end

  create_table "error_logs", force: true do |t|
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loggable_id"
    t.string   "loggable_type"
  end

  create_table "job_listings", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "body"
    t.text     "email"
    t.boolean  "remote"
    t.datetime "posted_at"
    t.text     "compensation"
    t.string   "craigslist_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "contract",      default: false
    t.boolean  "part_time",     default: false
    t.integer  "loggable_id"
    t.boolean  "duplicate",     default: false
  end

  add_index "job_listings", ["city_id", "posted_at"], name: "index_job_listings_on_city_id_and_posted_at", using: :btree
  add_index "job_listings", ["duplicate"], name: "index_job_listings_on_duplicate", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], name: "ru_comp_1", using: :btree

  create_table "settings", force: true do |t|
    t.boolean "rescrape_job_listings",            default: false
    t.integer "seconds_between_job_list_scrapes", default: 10
    t.boolean "monitor_job_lists",                default: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
