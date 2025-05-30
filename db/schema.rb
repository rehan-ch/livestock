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

ActiveRecord::Schema[7.1].define(version: 2025_05_30_113801) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.uuid "record_id", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "blogs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "status", default: 0
    t.datetime "published_at"
    t.string "tag_keywords"
    t.text "short_description"
    t.string "meta_title"
    t.text "meta_keywords"
    t.text "meta_description"
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_blogs_on_slug", unique: true
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.uuid "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "main_category_id"
    t.index ["main_category_id"], name: "index_categories_on_main_category_id"
  end

  create_table "chats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "seller_id", null: false
    t.uuid "buyer_id", null: false
    t.uuid "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id", "seller_id", "product_id"], name: "index_chats_on_buyer_id_and_seller_id_and_product_id", unique: true
    t.index ["buyer_id"], name: "index_chats_on_buyer_id"
    t.index ["product_id"], name: "index_chats_on_product_id"
    t.index ["seller_id"], name: "index_chats_on_seller_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "main_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "chat_id", null: false
    t.uuid "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "paid_ads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.integer "quantity"
    t.integer "status", default: 0
    t.integer "payment_method"
    t.integer "ad_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_paid_ads_on_user_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "category_id", null: false
    t.integer "status"
    t.integer "product_type"
    t.string "name"
    t.string "short_description"
    t.text "long_description"
    t.integer "quantity_unit"
    t.integer "sex"
    t.string "breed"
    t.float "height"
    t.float "weight"
    t.integer "teeth"
    t.boolean "castrated"
    t.integer "price"
    t.integer "quantity"
    t.string "city"
    t.string "country"
    t.string "state"
    t.string "address"
    t.boolean "self_stock"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "age", precision: 5, scale: 2
    t.boolean "pregnant"
    t.decimal "daily_milk_quantity"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone_no"
    t.string "farm_name"
    t.string "province"
    t.string "district"
    t.string "tehsil"
    t.text "address"
    t.integer "role", default: 0
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "number_of_ads", default: 5
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chats", "products"
  add_foreign_key "chats", "users", column: "buyer_id"
  add_foreign_key "chats", "users", column: "seller_id"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "paid_ads", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "users"
end
