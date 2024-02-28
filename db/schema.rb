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

ActiveRecord::Schema[7.0].define(version: 2024_02_28_020134) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "contact_categories", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_contact_categories_on_category_id"
    t.index ["contact_id"], name: "index_contact_categories_on_contact_id"
  end

  create_table "contact_cities", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "last_known_city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_cities_on_contact_id"
    t.index ["last_known_city_id"], name: "index_contact_cities_on_last_known_city_id"
  end

  create_table "contact_countries", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "last_known_country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_countries_on_contact_id"
    t.index ["last_known_country_id"], name: "index_contact_countries_on_last_known_country_id"
  end

  create_table "contact_groupings", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "contact_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_group_id"], name: "index_contact_groupings_on_contact_group_id"
    t.index ["contact_id"], name: "index_contact_groupings_on_contact_id"
  end

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

  create_table "contact_typings", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "contact_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_typings_on_contact_id"
    t.index ["contact_type_id"], name: "index_contact_typings_on_contact_type_id"
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
    t.date "birthday"
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
    t.bigint "category_id", default: 1, null: false
    t.date "date_first_met"
    t.bigint "last_known_country_id"
    t.bigint "last_known_city_id"
    t.index ["category_id"], name: "index_contacts_on_category_id"
    t.index ["last_known_city_id"], name: "index_contacts_on_last_known_city_id"
    t.index ["last_known_country_id"], name: "index_contacts_on_last_known_country_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "emotional_reactions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interact_interact_categories", force: :cascade do |t|
    t.bigint "interaction_id"
    t.bigint "interaction_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interaction_category_id"], name: "index_interact_interact_categories_on_interaction_category_id"
    t.index ["interaction_id"], name: "index_interact_interact_categories_on_interaction_id"
  end

  create_table "interaction_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interaction_emotional_reactions", force: :cascade do |t|
    t.bigint "emotional_reaction_id", null: false
    t.bigint "interaction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emotional_reaction_id", "interaction_id"], name: "index_interact_emotional_react_on_emotion_and_interact", unique: true
    t.index ["emotional_reaction_id"], name: "index_interaction_emotional_reactions_on_emotional_reaction_id"
    t.index ["interaction_id"], name: "index_interaction_emotional_reactions_on_interaction_id"
  end

  create_table "interaction_locations", force: :cascade do |t|
    t.bigint "interaction_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interaction_id"], name: "index_interaction_locations_on_interaction_id"
    t.index ["location_id"], name: "index_interaction_locations_on_location_id"
  end

  create_table "interaction_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "point_value"
  end

  create_table "interactions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contact_id"
    t.bigint "interaction_type_id"
    t.datetime "date"
    t.text "length"
    t.text "location"
    t.boolean "i_initiated", default: false
    t.integer "user_id"
    t.boolean "you_initiated_contact", default: true
    t.bigint "location_id"
    t.index ["contact_id"], name: "index_interactions_on_contact_id"
    t.index ["interaction_type_id"], name: "index_interactions_on_interaction_type_id"
  end

  create_table "last_known_cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_last_known_cities_on_user_id"
  end

  create_table "last_known_countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_last_known_countries_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "points", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contact_id"
    t.bigint "interaction_id"
    t.integer "interaction_type_points"
    t.integer "interaction_length_points"
    t.integer "emotional_reactions_points"
    t.integer "who_initiated_contact_points"
    t.index ["contact_id"], name: "index_points_on_contact_id"
    t.index ["interaction_id"], name: "index_points_on_interaction_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.boolean "vip", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "contact_cities", "contacts"
  add_foreign_key "contact_cities", "last_known_cities"
  add_foreign_key "contact_countries", "contacts"
  add_foreign_key "contact_countries", "last_known_countries"
  add_foreign_key "contacts", "categories"
  add_foreign_key "contacts", "last_known_cities"
  add_foreign_key "contacts", "last_known_countries"
  add_foreign_key "interaction_emotional_reactions", "emotional_reactions"
  add_foreign_key "interaction_emotional_reactions", "interactions"
  add_foreign_key "interaction_locations", "interactions"
  add_foreign_key "interaction_locations", "locations"
  add_foreign_key "interactions", "contacts"
  add_foreign_key "interactions", "interaction_types"
  add_foreign_key "last_known_cities", "users"
  add_foreign_key "last_known_countries", "users"
  add_foreign_key "locations", "users"
  add_foreign_key "points", "contacts"
  add_foreign_key "points", "interactions"
end
