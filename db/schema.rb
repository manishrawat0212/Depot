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

ActiveRecord::Schema.define(version: 20161015130613) do

  create_table "addresses", force: true do |t|
    t.string   "state"
    t.string   "city"
    t.string   "country"
    t.integer  "pincode"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id"

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "line_item_count", default: 0, null: false
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",      default: 0, null: false
  end

  create_table "images", force: true do |t|
    t.string   "url"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["product_id"], name: "index_images_on_product_id"

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
    t.integer  "user_id"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id"
  add_index "line_items", ["user_id"], name: "index_line_items_on_user_id"

  create_table "orders", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.decimal  "price",            precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",                                  default: false
    t.decimal  "discounted_price"
    t.string   "permalink"
    t.integer  "category_id"
    t.string   "category_type"
  end

  add_index "products", ["category_id", "category_type"], name: "index_products_on_category_id_and_category_type"
  add_index "products", ["permalink"], name: "index_products_on_permalink", unique: true

  create_table "ratings", force: true do |t|
    t.decimal  "rate",       precision: 3, scale: 1, default: 0.0
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["product_id"], name: "index_ratings_on_product_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "subcategories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",       default: 0, null: false
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "role",            default: "user",    null: false
    t.string   "language",        default: "english"
  end

  add_index "users", ["email"], name: "index_users_on_email"

end
