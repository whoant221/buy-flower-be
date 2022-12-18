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

ActiveRecord::Schema.define(version: 2022_12_18_184622) do

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

  create_table "buds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "count"
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

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.bigint "flower_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rank"
    t.index ["flower_id"], name: "index_comments_on_flower_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "flower_buds", force: :cascade do |t|
    t.bigint "flower_id", null: false
    t.bigint "bud_id", null: false
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bud_id"], name: "index_flower_buds_on_bud_id"
    t.index ["flower_id"], name: "index_flower_buds_on_flower_id"
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
    t.bigint "flower_id", null: false
    t.integer "amount"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flower_id"], name: "index_order_details_on_flower_id"
    t.index ["order_id"], name: "index_order_details_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "original_price"
    t.decimal "sale_price"
    t.string "receive_address"
    t.string "state"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "delivery_time"
    t.jsonb "additional_data"
    t.string "shipping_ref"
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

  create_table "user_vouchers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "voucher_id", null: false
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_vouchers_on_user_id"
    t.index ["voucher_id"], name: "index_user_vouchers_on_voucher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "point"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "voucher_orders", force: :cascade do |t|
    t.bigint "voucher_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_voucher_orders_on_order_id"
    t.index ["voucher_id"], name: "index_voucher_orders_on_voucher_id"
  end

  create_table "vouchers", force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.integer "limit_count"
    t.string "code"
    t.datetime "effective_at"
    t.datetime "expiration_at"
    t.decimal "discount"
    t.decimal "threshold"
    t.decimal "max_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "orders_count"
    t.integer "point"
    t.index ["code"], name: "index_vouchers_on_code"
  end

  add_foreign_key "category_flowers", "categories"
  add_foreign_key "category_flowers", "flowers"
  add_foreign_key "comments", "flowers"
  add_foreign_key "comments", "users"
  add_foreign_key "flower_buds", "buds"
  add_foreign_key "flower_buds", "flowers"
  add_foreign_key "order_details", "flowers"
  add_foreign_key "order_details", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "shopping_carts", "flowers"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "user_vouchers", "users"
  add_foreign_key "user_vouchers", "vouchers"
  add_foreign_key "voucher_orders", "orders"
  add_foreign_key "voucher_orders", "vouchers"
end
