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

ActiveRecord::Schema.define(version: 2020_09_26_043227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string "friendly_id"
    t.string "title", default: "", null: false
    t.integer "position"
    t.boolean "custom_thumbnail"
    t.bigint "issue_id"
    t.bigint "creator_id"
    t.integer "pages_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thumbnail"
    t.integer "media_count", default: 0
    t.text "content"
    t.text "description"
    t.string "social_title"
    t.integer "author_id"
    t.string "social_thumbnail"
    t.string "title_pic"
    t.index ["creator_id"], name: "index_articles_on_creator_id"
    t.index ["friendly_id"], name: "index_articles_on_friendly_id"
    t.index ["issue_id"], name: "index_articles_on_issue_id"
  end

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "hyperlinks", force: :cascade do |t|
    t.string "source_url"
    t.string "label_color"
    t.integer "coord_y"
    t.integer "coord_x"
    t.integer "coord_w"
    t.integer "coord_h"
    t.bigint "page_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["page_id"], name: "index_hyperlinks_on_page_id"
    t.index ["user_id"], name: "index_hyperlinks_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "friendly_id"
    t.string "title", default: "", null: false
    t.string "number", default: "", null: false
    t.string "role", default: "Issue", null: false
    t.integer "articles_count", default: 0
    t.string "orientation", default: "mobile", null: false
    t.date "published_on"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "preview_token"
    t.string "alias_name"
    t.index ["creator_id"], name: "index_issues_on_creator_id"
    t.index ["friendly_id"], name: "index_issues_on_friendly_id"
    t.index ["number"], name: "index_issues_on_number"
  end

  create_table "media", force: :cascade do |t|
    t.string "asset"
    t.string "override_url"
    t.string "friendly_id"
    t.integer "position"
    t.integer "issue_id"
    t.bigint "article_id"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "media_type"
    t.boolean "asset_processing", default: false, null: false
    t.index ["article_id"], name: "index_media_on_article_id"
    t.index ["creator_id"], name: "index_media_on_creator_id"
    t.index ["friendly_id"], name: "index_media_on_friendly_id"
    t.index ["issue_id"], name: "index_media_on_issue_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "friendly_id"
    t.string "title", default: "", null: false
    t.string "image"
    t.integer "position"
    t.integer "master_position"
    t.integer "issue_id"
    t.bigint "article_id"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "image_processing", default: false, null: false
    t.boolean "is_advertisement", default: false
    t.string "advertisement_thumb"
    t.boolean "full_page_ad"
    t.index ["article_id"], name: "index_pages_on_article_id"
    t.index ["creator_id"], name: "index_pages_on_creator_id"
    t.index ["friendly_id"], name: "index_pages_on_friendly_id"
    t.index ["issue_id"], name: "index_pages_on_issue_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "title", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "role", default: "User", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
