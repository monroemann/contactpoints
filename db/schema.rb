# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_09_181226) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_groups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_contact_groups_on_user_id"
  end

  create_table "contact_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_contact_types_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "last_known_country"
    t.string "last_known_city"
    t.string "mobile_phone_1"
    t.string "mobile_phone_2"
    t.string "office_phone_1"
    t.string "office_phone_2"
    t.string "home_phone"
    t.string "other_phone"
    t.string "email_1"
    t.string "email_2"
    t.string "email_3"
    t.string "email_4"
    t.string "email_5"
    t.string "website_1"
    t.string "website_2"
    t.string "website_3"
    t.string "website_4"
    t.string "website_5"
    t.string "website_6"
    t.string "website_7"
    t.string "website_8"
    t.string "contact_apps"
    t.string "birthday"
    t.text "address_1"
    t.text "address_2"
    t.text "how_we_met"
    t.string "things_I_like"
    t.text "best_memories"
    t.string "areas_for_improvement"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "points", default: 0
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "points", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
