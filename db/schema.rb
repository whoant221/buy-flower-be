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

ActiveRecord::Schema.define(version: 2022_11_16_073451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "category_flowers", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "flower_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_flowers_on_category_id"
    t.index ["flower_id"], name: "index_category_flowers_on_flower_id"
  end

  create_table "flower_details", force: :cascade do |t|
    t.bigint "flower_id", null: false
    t.integer "count"
    t.datetime "expiration_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "used_count", default: 0, null: false
    t.index ["flower_id"], name: "index_flower_details_on_flower_id"
  end

  create_table "flowers", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.decimal "original_price"
    t.decimal "sale_price"
    t.text "description"
    t.text "images", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "flower_detail_id", null: false
    t.integer "amount"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flower_detail_id"], name: "index_order_details_on_flower_detail_id"
    t.index ["order_id"], name: "index_order_details_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "original_price"
    t.decimal "sale_price"
    t.string "receive_address"
    t.string "note"
    t.string "state"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "flower_id", null: false
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flower_id"], name: "index_shopping_carts_on_flower_id"
    t.index ["user_id"], name: "index_shopping_carts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "category_flowers", "categories"
  add_foreign_key "category_flowers", "flowers"
  add_foreign_key "flower_details", "flowers"
  add_foreign_key "order_details", "flower_details"
  add_foreign_key "order_details", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "shopping_carts", "flowers"
  add_foreign_key "shopping_carts", "users"
end
