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

ActiveRecord::Schema.define(version: 2024_06_05_070008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "code_sequences", force: :cascade do |t|
    t.string "code"
    t.integer "year"
    t.integer "sequence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "sku"
    t.string "name"
    t.boolean "state"
    t.bigint "uom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uom_id"], name: "index_items_on_uom_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.boolean "state", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "item_id"
    t.decimal "price", precision: 15, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.boolean "state", default: true
    t.index ["item_id"], name: "index_prices_on_item_id"
  end

  create_table "receptions", force: :cascade do |t|
    t.string "number"
    t.bigint "item_id"
    t.integer "qty"
    t.text "notes"
    t.boolean "is_confirm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_receptions_on_item_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "item_id"
    t.integer "current_qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_stocks_on_item_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.decimal "percentage"
    t.integer "year"
    t.boolean "state", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uoms", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.boolean "state", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "uoms"
  add_foreign_key "prices", "items"
  add_foreign_key "receptions", "items"
  add_foreign_key "stocks", "items"
end
