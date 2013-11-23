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

ActiveRecord::Schema.define(version: 20131123220513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.string   "subdomain"
    t.string   "name"
    t.string   "state"
    t.string   "country"
    t.date     "last_scraped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbrev"
  end

  create_table "job_listings", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "body"
    t.text     "email"
    t.boolean  "remote"
    t.date     "posted_at"
    t.string   "compensation"
    t.string   "craigslist_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_listings", ["city_id", "posted_at"], name: "index_job_listings_on_city_id_and_posted_at", using: :btree

end
