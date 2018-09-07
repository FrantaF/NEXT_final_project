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

ActiveRecord::Schema.define(version: 2018_09_03_040729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.bigint "city_id"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_areas_on_city_id"
    t.index ["state_id"], name: "index_areas_on_state_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "address1", default: "", null: false
    t.string "address2"
    t.string "phone_number1", default: "", null: false
    t.string "phone_number2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dustbin_stats", force: :cascade do |t|
    t.bigint "dustbin_id"
    t.bigint "fill_level_id"
    t.datetime "collected_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dustbin_id"], name: "index_dustbin_stats_on_dustbin_id"
    t.index ["fill_level_id"], name: "index_dustbin_stats_on_fill_level_id"
  end

  create_table "dustbins", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "name", default: "", null: false
    t.string "address", default: "", null: false
    t.decimal "longitude"
    t.decimal "latitude"
    t.bigint "fill_level_id"
    t.datetime "last_collected"
    t.bigint "area_id"
    t.bigint "city_id"
    t.bigint "state_id"
    t.bigint "raspberrypi_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_dustbins_on_area_id"
    t.index ["city_id"], name: "index_dustbins_on_city_id"
    t.index ["fill_level_id"], name: "index_dustbins_on_fill_level_id"
    t.index ["raspberrypi_id"], name: "index_dustbins_on_raspberrypi_id"
    t.index ["state_id"], name: "index_dustbins_on_state_id"
  end

  create_table "fill_levels", force: :cascade do |t|
    t.integer "level"
    t.string "percentage"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "raspberrypis", force: :cascade do |t|
    t.string "pi_name"
    t.string "pi_type"
    t.string "ip_address"
    t.string "mac_address"
    t.bigint "memory_size"
    t.decimal "longitude"
    t.decimal "latitude"
    t.string "spec1"
    t.string "spec2"
    t.string "spec3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_dustbin_assignments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "dustbin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dustbin_id"], name: "index_user_dustbin_assignments_on_dustbin_id"
    t.index ["user_id"], name: "index_user_dustbin_assignments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "phone_number"
    t.integer "role", default: 2
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
