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

ActiveRecord::Schema.define(version: 20160523193712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "verb"
    t.integer  "user_id"
    t.integer  "activity_feedable_id"
    t.string   "activity_feedable_type"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "activities", ["activity_feedable_id"], name: "index_activities_on_activity_feedable_id", using: :btree
  add_index "activities", ["activity_feedable_type"], name: "index_activities_on_activity_feedable_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree
  add_index "activities", ["verb"], name: "index_activities_on_verb", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["parent_type", "parent_id"], name: "index_comments_on_parent_type_and_parent_id", using: :btree

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

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "initiator_id", null: false
    t.integer  "following_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "follows", ["initiator_id", "following_id"], name: "index_follows_on_initiator_id_and_following_id", unique: true, using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "likes", ["parent_type", "parent_id"], name: "index_likes_on_parent_type_and_parent_id", using: :btree
  add_index "likes", ["user_id", "parent_id", "parent_type"], name: "index_likes_on_user_id_and_parent_id_and_parent_type", unique: true, using: :btree

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

  add_index "photos", ["attachable_id"], name: "index_photos_on_attachable_id", using: :btree
  add_index "photos", ["attachable_type"], name: "index_photos_on_attachable_type", using: :btree

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

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "snap_it_languages", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "editor_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "snap_it_languages", ["editor_name"], name: "index_snap_it_languages_on_editor_name", unique: true, using: :btree
  add_index "snap_it_languages", ["name"], name: "index_snap_it_languages_on_name", unique: true, using: :btree

  create_table "snap_it_proxies", force: :cascade do |t|
    t.string   "title",                            null: false
    t.text     "description",                      null: false
    t.text     "body",                             null: false
    t.string   "token"
    t.integer  "user_id",                          null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "snap_it_language_id"
    t.integer  "snap_it_theme_id"
    t.text     "image_data"
    t.integer  "font_size",           default: 18
    t.integer  "wrap_limit"
  end

  add_index "snap_it_proxies", ["font_size"], name: "index_snap_it_proxies_on_font_size", using: :btree
  add_index "snap_it_proxies", ["snap_it_language_id"], name: "index_snap_it_proxies_on_snap_it_language_id", using: :btree
  add_index "snap_it_proxies", ["snap_it_theme_id"], name: "index_snap_it_proxies_on_snap_it_theme_id", using: :btree
  add_index "snap_it_proxies", ["token"], name: "index_snap_it_proxies_on_token", unique: true, using: :btree
  add_index "snap_it_proxies", ["user_id"], name: "index_snap_it_proxies_on_user_id", using: :btree
  add_index "snap_it_proxies", ["wrap_limit"], name: "index_snap_it_proxies_on_wrap_limit", using: :btree

  create_table "snap_it_themes", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "editor_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "snap_it_themes", ["editor_name"], name: "index_snap_it_themes_on_editor_name", unique: true, using: :btree
  add_index "snap_it_themes", ["name"], name: "index_snap_it_themes_on_name", unique: true, using: :btree

  create_table "snap_its", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "photo_id"
    t.string   "title",                            null: false
    t.text     "description",                      null: false
    t.text     "body",                             null: false
    t.integer  "font_size",           default: 18
    t.integer  "user_id",                          null: false
    t.integer  "snap_it_language_id",              null: false
    t.integer  "snap_it_theme_id",                 null: false
    t.integer  "wrap_limit"
  end

  add_index "snap_its", ["font_size"], name: "index_snap_its_on_font_size", using: :btree
  add_index "snap_its", ["photo_id"], name: "index_snap_its_on_photo_id", unique: true, using: :btree
  add_index "snap_its", ["snap_it_language_id"], name: "index_snap_its_on_snap_it_language_id", using: :btree
  add_index "snap_its", ["snap_it_theme_id"], name: "index_snap_its_on_snap_it_theme_id", using: :btree
  add_index "snap_its", ["title"], name: "index_snap_its_on_title", using: :btree
  add_index "snap_its", ["user_id"], name: "index_snap_its_on_user_id", using: :btree
  add_index "snap_its", ["wrap_limit"], name: "index_snap_its_on_wrap_limit", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

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

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
