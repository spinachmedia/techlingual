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

ActiveRecord::Schema.define(version: 20170606050001) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true

  create_table "dictionary_msts", force: :cascade do |t|
    t.text     "word"
    t.text     "mean"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "idiom_msts", force: :cascade do |t|
    t.text     "idiom"
    t.text     "mean"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ignore_word_msts", force: :cascade do |t|
    t.text     "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "url_msts", force: :cascade do |t|
    t.text     "name"
    t.text     "domain"
    t.text     "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "word_infos", force: :cascade do |t|
    t.integer  "url_mst_id"
    t.text     "word"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "word_rank_infos", force: :cascade do |t|
    t.text     "word"
    t.integer  "count"
    t.integer  "url_mst_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
