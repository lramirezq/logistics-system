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

ActiveRecord::Schema[8.0].define(version: 2025_11_20_014553) do
  create_table "communes", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "province_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id"], name: "index_communes_on_province_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "company_type", null: false
    t.string "tax_id"
    t.text "address"
    t.string "phone"
    t.string "email"
    t.integer "parent_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.string "region"
    t.string "province"
    t.string "commune"
    t.string "codigo"
    t.string "razon_social"
    t.string "nombre_comercial"
    t.string "tipo_empresa", default: "COMPANIA", null: false
    t.index ["codigo"], name: "index_companies_on_codigo", unique: true
    t.index ["company_type"], name: "index_companies_on_company_type"
    t.index ["parent_id"], name: "index_companies_on_parent_id"
  end

  create_table "company_relationships", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "related_company_id", null: false
    t.string "relationship_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "related_company_id", "relationship_type"], name: "idx_company_relationships_unique", unique: true
    t.index ["client_id"], name: "index_company_relationships_on_client_id"
    t.index ["related_company_id"], name: "index_company_relationships_on_related_company_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "position"
    t.string "phone"
    t.string "email"
    t.integer "company_id", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_contacts_on_company_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso2"
    t.string "iso3"
    t.string "phone_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operations", force: :cascade do |t|
    t.integer "numero_operacion"
    t.string "tipo_operacion"
    t.date "fecha"
    t.integer "shipper_id"
    t.integer "consignatario_id"
    t.integer "ref_cliente_id"
    t.string "emisor_master"
    t.string "vessel_vuelo"
    t.date "etd"
    t.date "eta"
    t.string "origen"
    t.string "destino"
    t.integer "agente_id"
    t.integer "compania_id"
    t.string "naviera"
    t.string "numero_contenedor"
    t.decimal "volumen", precision: 10, scale: 2
    t.decimal "peso", precision: 10, scale: 2
    t.string "bl_master"
    t.string "bl_hijo"
    t.decimal "fact_afecta", precision: 12, scale: 2
    t.decimal "fact_exenta", precision: 12, scale: 2
    t.decimal "fact_extranj", precision: 12, scale: 2
    t.decimal "compra_afecta", precision: 12, scale: 2
    t.decimal "compra_exenta", precision: 12, scale: 2
    t.text "observaciones"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agente_id"], name: "index_operations_on_agente_id"
    t.index ["compania_id"], name: "index_operations_on_compania_id"
    t.index ["consignatario_id"], name: "index_operations_on_consignatario_id"
    t.index ["fecha"], name: "index_operations_on_fecha"
    t.index ["numero_operacion"], name: "index_operations_on_numero_operacion", unique: true
    t.index ["ref_cliente_id"], name: "index_operations_on_ref_cliente_id"
    t.index ["shipper_id"], name: "index_operations_on_shipper_id"
    t.index ["tipo_operacion"], name: "index_operations_on_tipo_operacion"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.integer "region_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_provinces_on_region_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.integer "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "communes", "provinces"
  add_foreign_key "company_relationships", "companies", column: "client_id"
  add_foreign_key "company_relationships", "companies", column: "related_company_id"
  add_foreign_key "contacts", "companies"
  add_foreign_key "operations", "companies", column: "agente_id"
  add_foreign_key "operations", "companies", column: "compania_id"
  add_foreign_key "operations", "companies", column: "consignatario_id"
  add_foreign_key "operations", "companies", column: "ref_cliente_id"
  add_foreign_key "operations", "companies", column: "shipper_id"
  add_foreign_key "provinces", "regions"
  add_foreign_key "regions", "countries"
end
