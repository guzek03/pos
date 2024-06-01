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

ActiveRecord::Schema.define(version: 2024_06_01_154545) do

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
    t.index ["item_id"], name: "index_prices_on_item_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "item_id"
    t.integer "initial_qty"
    t.integer "current_quantity"
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

  add_foreign_key "items", "uoms"
  add_foreign_key "prices", "items"
  add_foreign_key "stocks", "items"
end
