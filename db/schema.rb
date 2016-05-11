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

ActiveRecord::Schema.define(version: 20160511013801) do

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

  create_table "follows", force: :cascade do |t|
    t.integer  "initiator_id", null: false
    t.integer  "following_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "follows", ["initiator_id", "following_id"], name: "index_follows_on_initiator_id_and_following_id", unique: true

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "photos", force: :cascade do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "photos", ["attachable_id"], name: "index_photos_on_attachable_id"
  add_index "photos", ["attachable_type"], name: "index_photos_on_attachable_type"

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
    t.integer  "wrap_limit"
  end

  add_index "snap_it_proxies", ["font_size"], name: "index_snap_it_proxies_on_font_size"
  add_index "snap_it_proxies", ["snap_it_language_id"], name: "index_snap_it_proxies_on_snap_it_language_id"
  add_index "snap_it_proxies", ["snap_it_theme_id"], name: "index_snap_it_proxies_on_snap_it_theme_id"
  add_index "snap_it_proxies", ["token"], name: "index_snap_it_proxies_on_token", unique: true
  add_index "snap_it_proxies", ["user_id"], name: "index_snap_it_proxies_on_user_id"
  add_index "snap_it_proxies", ["wrap_limit"], name: "index_snap_it_proxies_on_wrap_limit"

  create_table "snap_it_themes", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "editor_name", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "snap_it_themes", ["editor_name"], name: "index_snap_it_themes_on_editor_name", unique: true
  add_index "snap_it_themes", ["name"], name: "index_snap_it_themes_on_name", unique: true

  create_table "snap_its", force: :cascade do |t|
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "photo_id"
    t.string   "title",                                        null: false
    t.text     "description",         limit: 512,              null: false
    t.text     "body",                                         null: false
    t.integer  "font_size",                       default: 18
    t.integer  "user_id",                                      null: false
    t.integer  "snap_it_language_id",                          null: false
    t.integer  "snap_it_theme_id",                             null: false
    t.integer  "wrap_limit"
  end

  add_index "snap_its", ["font_size"], name: "index_snap_its_on_font_size"
  add_index "snap_its", ["photo_id"], name: "index_snap_its_on_photo_id", unique: true
  add_index "snap_its", ["snap_it_language_id"], name: "index_snap_its_on_snap_it_language_id"
  add_index "snap_its", ["snap_it_theme_id"], name: "index_snap_its_on_snap_it_theme_id"
  add_index "snap_its", ["title"], name: "index_snap_its_on_title"
  add_index "snap_its", ["user_id"], name: "index_snap_its_on_user_id"
  add_index "snap_its", ["wrap_limit"], name: "index_snap_its_on_wrap_limit"

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
    t.string   "slug"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
