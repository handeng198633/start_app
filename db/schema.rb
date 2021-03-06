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

ActiveRecord::Schema.define(version: 20151010090129) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["user_id", "created_at"], name: "index_articles_on_user_id_and_created_at"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "joblogs", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.integer  "sqajob_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "jobname",    limit: 255
  end

  create_table "microposts", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "sqajobs", force: :cascade do |t|
    t.string   "jobname",        limit: 255
    t.text     "case_group"
    t.string   "gversion",       limit: 255
    t.string   "nversion",       limit: 255
    t.string   "gbuild",         limit: 255
    t.string   "nbuild",         limit: 255
    t.string   "gsrfile",        limit: 255
    t.string   "genv",           limit: 255
    t.string   "nenv",           limit: 255
    t.string   "case_list_file", limit: 255
    t.integer  "slotthread"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "job_state",      limit: 255, default: "notrun"
    t.datetime "starttime"
    t.string   "jobresult"
  end

  add_index "sqajobs", ["user_id", "created_at"], name: "index_sqajobs_on_user_id_and_created_at"

  create_table "sqajobstatuses", force: :cascade do |t|
    t.integer  "sqajob_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest",        limit: 255
    t.string   "remember_token",         limit: 255
    t.boolean  "admin"
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "remember_digest",        limit: 255
    t.string   "activation_digest",      limit: 255
    t.boolean  "activated",                          default: false
    t.datetime "activated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
