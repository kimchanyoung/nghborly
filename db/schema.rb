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

ActiveRecord::Schema.define(version: 20151031184023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string   "primary_number",     null: false
    t.string   "street_name",        null: false
    t.string   "street_suffix",      null: false
    t.string   "city_name",          null: false
    t.string   "state_abbreviation", null: false
    t.string   "zipcode",            null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    

  create_table "messages", force: :cascade do |t|
    t.integer "request_id",             null: false
    t.string  "content",    limit: 140, null: false
    t.integer "sender_id",              null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string   "content",                      null: false
    t.integer  "requester_id",                 null: false
    t.integer  "responder_id"
    t.boolean  "is_fulfilled", default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "request_id",       null: false
    t.string   "transaction_type", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_id",    null: false
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "email",      null: false
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "voter_id",     null: false
    t.integer  "candidate_id", null: false
    t.integer  "value",        null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
