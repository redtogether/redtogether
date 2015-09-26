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

ActiveRecord::Schema.define(version: 20150925200757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channel_subscriptions", force: :cascade do |t|
    t.integer  "user_id",      index: {name: "index_channel_subscriptions_on_user_id"}
    t.string   "channel_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string   "name",        index: {name: "index_channels_on_lower_name", unique: true, case_sensitive: false}
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id",    index: {name: "index_comments_on_post_id"}
    t.integer  "user_id",    index: {name: "index_comments_on_user_id"}
    t.string   "body"
    t.integer  "parent_id",  index: {name: "index_comments_on_parent_id"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug",       index: {name: "index_comments_on_slug"}
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "channel_name"
    t.string   "slug",           index: {name: "index_posts_on_slug"}
    t.integer  "user_id",        index: {name: "index_posts_on_user_id"}
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "comments_count"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false, index: {name: "index_users_on_email", unique: true}
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token",   index: {name: "index_users_on_reset_password_token", unique: true}
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "confirmation_token",     index: {name: "index_users_on_confirmation_token", unique: true}
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "handle"
  end

end
