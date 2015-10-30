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


ActiveRecord::Schema.define(version: 20151030165527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "address",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["address"], name: "index_groups_on_address", unique: true, using: :btree

  create_table "requests", force: :cascade do |t|
    t.string   "content",                      null: false
    t.integer  "requester_id",                 null: false
    t.integer  "responder_id"
    t.boolean  "isFulfilled",  default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "password_digest", null: false
    t.string   "email",           null: false
    t.string   "phone"
    t.integer  "group_id",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "userinfo"
    t.string   "name"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "voter_id",     null: false
    t.integer  "candidate_id", null: false
    t.integer  "value",        null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
