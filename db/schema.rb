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

ActiveRecord::Schema[7.0].define(version: 2022_05_28_125741) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "deadlines", force: :cascade do |t|
    t.decimal "min_distance"
    t.decimal "max_distance"
    t.decimal "deadline_in_days"
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_company_id"], name: "index_deadlines_on_shipping_company_id"
  end

  create_table "functionaries", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id"
    t.index ["email"], name: "index_functionaries_on_email", unique: true
    t.index ["reset_password_token"], name: "index_functionaries_on_reset_password_token", unique: true
    t.index ["shipping_company_id"], name: "index_functionaries_on_shipping_company_id"
  end

  create_table "price_settings", force: :cascade do |t|
    t.decimal "min_weight"
    t.decimal "max_weight"
    t.decimal "max_cubic_meter"
    t.decimal "min_cubic_meter"
    t.decimal "distance_value"
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_company_id"], name: "index_price_settings_on_shipping_company_id"
  end

  create_table "product_models", force: :cascade do |t|
    t.string "name"
    t.decimal "weight"
    t.decimal "width"
    t.decimal "height"
    t.decimal "depth"
    t.string "sku"
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_company_id"], name: "index_product_models_on_shipping_company_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.integer "shipping_company_id", null: false
    t.integer "vehicle_id", null: false
    t.integer "product_model_id", null: false
    t.string "full_address"
    t.string "customer_address"
    t.string "customer_name"
    t.date "estimated_delivery_date"
    t.string "integer", default: "0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.index ["product_model_id"], name: "index_service_orders_on_product_model_id"
    t.index ["shipping_company_id"], name: "index_service_orders_on_shipping_company_id"
    t.index ["vehicle_id"], name: "index_service_orders_on_vehicle_id"
  end

  create_table "shipping_companies", force: :cascade do |t|
    t.string "fantasy_name"
    t.string "corporate_name"
    t.string "email"
    t.string "cnpj"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "cep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email_domain"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate"
    t.string "brand"
    t.string "year_fabrication"
    t.string "model"
    t.string "freight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id", null: false
    t.index ["shipping_company_id"], name: "index_vehicles_on_shipping_company_id"
  end

  add_foreign_key "deadlines", "shipping_companies"
  add_foreign_key "functionaries", "shipping_companies"
  add_foreign_key "price_settings", "shipping_companies"
  add_foreign_key "product_models", "shipping_companies"
  add_foreign_key "service_orders", "product_models"
  add_foreign_key "service_orders", "shipping_companies"
  add_foreign_key "service_orders", "vehicles"
  add_foreign_key "vehicles", "shipping_companies"
end
