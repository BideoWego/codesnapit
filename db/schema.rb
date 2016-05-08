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

ActiveRecord::Schema.define(version: 20160508010332) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "full_name"
    t.string   "website"
    t.text     "bio"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "gravatar",            default: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "snap_it_languages", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "editor_name", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "snap_it_languages", ["editor_name"], name: "index_snap_it_languages_on_editor_name", unique: true
  add_index "snap_it_languages", ["name"], name: "index_snap_it_languages_on_name", unique: true

  create_table "snap_it_proxies", force: :cascade do |t|
    t.string   "title",                                        null: false
    t.text     "description",         limit: 512,              null: false
    t.text     "body",                                         null: false
    t.string   "token"
    t.integer  "user_id",                                      null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "snap_it_language_id"
    t.integer  "snap_it_theme_id"
    t.text     "image_data"
    t.integer  "font_size",                       default: 18
  end

  add_index "snap_it_proxies", ["font_size"], name: "index_snap_it_proxies_on_font_size"
  add_index "snap_it_proxies", ["snap_it_language_id"], name: "index_snap_it_proxies_on_snap_it_language_id"
  add_index "snap_it_proxies", ["snap_it_theme_id"], name: "index_snap_it_proxies_on_snap_it_theme_id"
  add_index "snap_it_proxies", ["token"], name: "index_snap_it_proxies_on_token", unique: true
  add_index "snap_it_proxies", ["user_id"], name: "index_snap_it_proxies_on_user_id"

  create_table "snap_it_themes", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "editor_name", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "snap_it_themes", ["editor_name"], name: "index_snap_it_themes_on_editor_name", unique: true
  add_index "snap_it_themes", ["name"], name: "index_snap_it_themes_on_name", unique: true

  create_table "snap_its", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                          null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "email",                default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
