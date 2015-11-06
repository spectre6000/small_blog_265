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

ActiveRecord::Schema.define(version: 20151106210236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "username",                   default: "",    null: false
    t.string   "email",                      default: "",    null: false
    t.string   "encrypted_password",         default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",            default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",          default: 0
    t.boolean  "admin",                      default: false
    t.text     "bio"
    t.string   "location"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
  end

  add_index "authors", ["confirmation_token"], name: "index_authors_on_confirmation_token", unique: true, using: :btree
  add_index "authors", ["email"], name: "index_authors_on_email", unique: true, using: :btree
  add_index "authors", ["invitation_token"], name: "index_authors_on_invitation_token", unique: true, using: :btree
  add_index "authors", ["invitations_count"], name: "index_authors_on_invitations_count", using: :btree
  add_index "authors", ["invited_by_id"], name: "index_authors_on_invited_by_id", using: :btree
  add_index "authors", ["reset_password_token"], name: "index_authors_on_reset_password_token", unique: true, using: :btree
  add_index "authors", ["unlock_token"], name: "index_authors_on_unlock_token", unique: true, using: :btree
  add_index "authors", ["username"], name: "index_authors_on_username", unique: true, using: :btree

end
