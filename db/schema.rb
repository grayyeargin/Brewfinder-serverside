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

ActiveRecord::Schema.define(version: 20150212225142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beers", force: true do |t|
    t.string   "name"
    t.string   "style"
    t.string   "image"
    t.integer  "brewery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "abv",         precision: 5, scale: 2
    t.text     "description"
    t.integer  "like_no"
    t.integer  "rating_no"
    t.decimal  "avg_rating",  precision: 5, scale: 2
  end

  create_table "breweries", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
    t.string   "address"
    t.string   "phone_number"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "follows", force: true do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "beer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "rating"
    t.integer  "beer_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["beer_id"], name: "index_reviews_on_beer_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "styles", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "password_digest"
    t.string   "username"
    t.string   "image_url"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birthdate"
    t.string   "city"
    t.string   "state"
  end

end
