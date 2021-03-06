# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_10_062451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_logs", force: :cascade do |t|
    t.string "state"
    t.string "action_code"
    t.string "action_label"
    t.jsonb "action_data"
    t.jsonb "context"
    t.bigint "actor_id"
    t.string "actionable_type"
    t.bigint "actionable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "error"
  end

  create_table "auction_products", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "creator_id"
    t.float "price"
    t.float "cost"
    t.jsonb "extra"
    t.string "title"
    t.bigint "winner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.datetime "finish_at"
    t.datetime "start_at"
    t.float "current_price"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "code"
    t.jsonb "shipping_address"
    t.float "total"
    t.float "shipping_fee"
    t.string "phone"
    t.string "email"
    t.datetime "paid_at"
    t.boolean "cancelled"
    t.datetime "cancelled_at"
    t.string "cancelled_reason"
    t.string "currency"
    t.string "note"
    t.bigint "auction_id"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "owner_id"
    t.bigint "customer_id"
    t.string "status"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "tags"
    t.float "quality_commitment"
    t.float "price"
    t.bigint "creator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.jsonb "categories"
    t.string "images", array: true
  end

  create_table "security_gateways", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "steps", default: {}
  end

  create_table "user_security_gateways", force: :cascade do |t|
    t.bigint "security_gateway_id", null: false
    t.bigint "user_id", null: false
    t.integer "current_step"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["security_gateway_id"], name: "index_user_security_gateways_on_security_gateway_id"
    t.index ["user_id"], name: "index_user_security_gateways_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "phone"
    t.datetime "birthday"
    t.string "current_app"
    t.jsonb "address"
    t.jsonb "id_card"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "user_security_gateways", "security_gateways"
  add_foreign_key "user_security_gateways", "users"
end
