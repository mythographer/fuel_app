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

ActiveRecord::Schema.define(version: 20160908071151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cost_centres", force: :cascade do |t|
    t.string   "name_en",    limit: 30, null: false
    t.string   "name_ua",    limit: 30, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name_en"], name: "index_cost_centres_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_cost_centres_on_name_ua", unique: true, using: :btree
  end

  create_table "engine_powers", force: :cascade do |t|
    t.string   "name_en",    limit: 5, null: false
    t.string   "name_ua",    limit: 5, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["name_en"], name: "index_engine_powers_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_engine_powers_on_name_ua", unique: true, using: :btree
  end

  create_table "engines", force: :cascade do |t|
    t.decimal  "capacity_l",      precision: 3, scale: 1,             null: false
    t.integer  "capacity_cc",                                         null: false
    t.integer  "fuel_brand_id",                                       null: false
    t.integer  "power",                                               null: false
    t.integer  "engine_power_id",                                     null: false
    t.integer  "cylinder_count",                          default: 4, null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["capacity_l", "capacity_cc", "fuel_brand_id", "power", "engine_power_id"], name: "UK_engines", unique: true, using: :btree
    t.index ["engine_power_id"], name: "index_engines_on_engine_power_id", using: :btree
    t.index ["fuel_brand_id"], name: "index_engines_on_fuel_brand_id", using: :btree
  end

  create_table "fleets", force: :cascade do |t|
    t.string   "name_en",    limit: 30, null: false
    t.string   "name_ua",    limit: 30, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name_en"], name: "index_fleets_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_fleets_on_name_ua", unique: true, using: :btree
  end

  create_table "fuel_brands", force: :cascade do |t|
    t.string   "name_en",      limit: 10, null: false
    t.string   "name_ua",      limit: 10, null: false
    t.integer  "fuel_type_id",            null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["fuel_type_id"], name: "index_fuel_brands_on_fuel_type_id", using: :btree
    t.index ["name_en"], name: "index_fuel_brands_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_fuel_brands_on_name_ua", unique: true, using: :btree
  end

  create_table "fuel_card_brands", force: :cascade do |t|
    t.string   "brand_name", limit: 50, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["brand_name"], name: "index_fuel_card_brands_on_brand_name", unique: true, using: :btree
  end

  create_table "fuel_cards", force: :cascade do |t|
    t.string   "card_no",            limit: 50, null: false
    t.integer  "fuel_card_brand_id",            null: false
    t.text     "notes"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["fuel_card_brand_id", "card_no"], name: "index_fuel_cards_on_fuel_card_brand_id_and_card_no", unique: true, using: :btree
    t.index ["fuel_card_brand_id"], name: "index_fuel_cards_on_fuel_card_brand_id", using: :btree
  end

  create_table "fuel_checks", force: :cascade do |t|
    t.string   "check_no",       limit: 20
    t.datetime "check_datetime",                                     null: false
    t.integer  "fuel_card_id"
    t.integer  "fuel_brand_id",                                      null: false
    t.decimal  "quantity",                  precision: 6,  scale: 2, null: false
    t.decimal  "unit_price",                precision: 15, scale: 2, null: false
    t.decimal  "total_vat",                 precision: 15, scale: 2, null: false
    t.integer  "waybill_id"
    t.integer  "mileage"
    t.integer  "vehicle_id"
    t.text     "comment"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.index ["fuel_brand_id"], name: "index_fuel_checks_on_fuel_brand_id", using: :btree
    t.index ["fuel_card_id"], name: "index_fuel_checks_on_fuel_card_id", using: :btree
    t.index ["vehicle_id"], name: "index_fuel_checks_on_vehicle_id", using: :btree
    t.index ["waybill_id"], name: "index_fuel_checks_on_waybill_id", using: :btree
  end

  create_table "fuel_types", force: :cascade do |t|
    t.string   "name_en",    limit: 10, null: false
    t.string   "name_ua",    limit: 10, null: false
    t.string   "abbr_name",  limit: 1,  null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["abbr_name"], name: "index_fuel_types_on_abbr_name", unique: true, using: :btree
    t.index ["name_en"], name: "index_fuel_types_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_fuel_types_on_name_ua", unique: true, using: :btree
  end

  create_table "gearboxes", force: :cascade do |t|
    t.string   "name_en",    limit: 20,                 null: false
    t.string   "name_ua",    limit: 20,                 null: false
    t.boolean  "automatic",             default: false, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["name_en"], name: "index_gearboxes_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_gearboxes_on_name_ua", unique: true, using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name_en",    limit: 255, null: false
    t.string   "name_ua",    limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["name_en"], name: "index_subjects_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_subjects_on_name_ua", unique: true, using: :btree
  end

  create_table "vehicle_body_types", force: :cascade do |t|
    t.string   "name_en",    limit: 20, null: false
    t.string   "name_ua",    limit: 20, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name_en"], name: "index_vehicle_body_types_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_vehicle_body_types_on_name_ua", unique: true, using: :btree
  end

  create_table "vehicle_bodyworks", force: :cascade do |t|
    t.integer  "vehicle_model_id",          null: false
    t.integer  "vehicle_mark_body_type_id", null: false
    t.integer  "doors_count",               null: false
    t.integer  "seating_capacity",          null: false
    t.integer  "vehicle_category_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["vehicle_mark_body_type_id"], name: "index_vehicle_bodyworks_on_vehicle_mark_body_type_id", using: :btree
    t.index ["vehicle_model_id", "vehicle_mark_body_type_id", "doors_count", "seating_capacity", "vehicle_category_id"], name: "uk_vehicle_bodyworks", using: :btree
    t.index ["vehicle_model_id"], name: "index_vehicle_bodyworks_on_vehicle_model_id", using: :btree
  end

  create_table "vehicle_categories", force: :cascade do |t|
    t.string   "name_en",    limit: 25, null: false
    t.string   "name_ua",    limit: 25, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name_en"], name: "index_vehicle_categories_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_vehicle_categories_on_name_ua", unique: true, using: :btree
  end

  create_table "vehicle_configurations", force: :cascade do |t|
    t.integer  "vehicle_bodywork_id",                   null: false
    t.integer  "vehicle_trim_level_id",                 null: false
    t.integer  "engine_id",                             null: false
    t.integer  "gearbox_id",                            null: false
    t.boolean  "awd",                   default: false, null: false
    t.integer  "fuel_capacity"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["engine_id"], name: "index_vehicle_configurations_on_engine_id", using: :btree
    t.index ["gearbox_id"], name: "index_vehicle_configurations_on_gearbox_id", using: :btree
    t.index ["vehicle_bodywork_id"], name: "index_vehicle_configurations_on_vehicle_bodywork_id", using: :btree
    t.index ["vehicle_trim_level_id"], name: "index_vehicle_configurations_on_vehicle_trim_level_id", using: :btree
  end

  create_table "vehicle_groups", force: :cascade do |t|
    t.string   "name",       limit: 1, null: false
    t.text     "descr"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["name"], name: "index_vehicle_groups_on_name", unique: true, using: :btree
  end

  create_table "vehicle_inventories", force: :cascade do |t|
    t.integer  "vehicle_id", null: false
    t.date     "date_in",    null: false
    t.date     "date_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id", "date_in"], name: "uk_vehicle_inventories", unique: true, using: :btree
    t.index ["vehicle_id"], name: "index_vehicle_inventories_on_vehicle_id", using: :btree
  end

  create_table "vehicle_mark_body_types", force: :cascade do |t|
    t.string   "name_en",              limit: 20, null: false
    t.string   "name_ua",              limit: 20, null: false
    t.integer  "vehicle_trademark_id",            null: false
    t.integer  "vehicle_body_type_id",            null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["vehicle_body_type_id"], name: "index_vehicle_mark_body_types_on_vehicle_body_type_id", using: :btree
    t.index ["vehicle_trademark_id", "name_en"], name: "uk_vehicle_mark_body_types_on_vehicle_tm_id_and_name_en", unique: true, using: :btree
    t.index ["vehicle_trademark_id", "name_ua"], name: "uk_vehicle_mark_body_types_on_vehicle_tm_id_and_name_ua", unique: true, using: :btree
    t.index ["vehicle_trademark_id"], name: "index_vehicle_mark_body_types_on_vehicle_trademark_id", using: :btree
  end

  create_table "vehicle_models", force: :cascade do |t|
    t.string   "name_en",              limit: 50,             null: false
    t.string   "name_ua",              limit: 50,             null: false
    t.integer  "vehicle_trademark_id",                        null: false
    t.integer  "vehicle_group_id"
    t.integer  "wheel_count",                     default: 4, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["vehicle_group_id"], name: "index_vehicle_models_on_vehicle_group_id", using: :btree
    t.index ["vehicle_trademark_id", "name_en"], name: "index_vehicle_models_on_vehicle_trademark_id_and_name_en", unique: true, using: :btree
    t.index ["vehicle_trademark_id", "name_ua"], name: "index_vehicle_models_on_vehicle_trademark_id_and_name_ua", unique: true, using: :btree
    t.index ["vehicle_trademark_id"], name: "index_vehicle_models_on_vehicle_trademark_id", using: :btree
  end

  create_table "vehicle_registration_colors", force: :cascade do |t|
    t.string   "name_ua",    limit: 20, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name_ua"], name: "index_vehicle_registration_colors_on_name_ua", unique: true, using: :btree
  end

  create_table "vehicle_registrations", force: :cascade do |t|
    t.string   "doc_series",                    limit: 5
    t.string   "doc_no",                        limit: 10
    t.boolean  "without_sn",                               default: false, null: false
    t.date     "reg_date",                                                 null: false
    t.integer  "vro_subject_id"
    t.boolean  "temporary",                                default: false, null: false
    t.string   "vin",                           limit: 17,                 null: false
    t.string   "reg_no",                        limit: 10,                 null: false
    t.integer  "manufacture_year",                                         null: false
    t.integer  "vehicle_registration_color_id",                            null: false
    t.integer  "vehicle_body_type_id"
    t.integer  "total_weight"
    t.integer  "engine_capacity_cc"
    t.integer  "seating_capacity"
    t.text     "special_notes"
    t.text     "ext_reference"
    t.integer  "vehicle_id"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.index ["doc_series", "doc_no"], name: "index_vehicle_registrations_on_doc_series_and_doc_no", unique: true, where: "without_sn", using: :btree
    t.index ["vehicle_body_type_id"], name: "index_vehicle_registrations_on_vehicle_body_type_id", using: :btree
    t.index ["vehicle_id"], name: "index_vehicle_registrations_on_vehicle_id", using: :btree
    t.index ["vehicle_registration_color_id"], name: "index_vehicle_registrations_on_vehicle_registration_color_id", using: :btree
    t.index ["vro_subject_id"], name: "index_vehicle_registrations_on_vro_subject_id", using: :btree
  end

  create_table "vehicle_statuses", force: :cascade do |t|
    t.string   "name_en",    limit: 30, null: false
    t.string   "name_ua",    limit: 30, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name_en"], name: "index_vehicle_statuses_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_vehicle_statuses_on_name_ua", unique: true, using: :btree
  end

  create_table "vehicle_trademark_colors", force: :cascade do |t|
    t.string   "name_en",    limit: 50, null: false
    t.string   "name_ua",    limit: 50, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name_en"], name: "index_vehicle_trademark_colors_on_name_en", unique: true, using: :btree
  end

  create_table "vehicle_trademarks", force: :cascade do |t|
    t.string   "name_en",    limit: 50, null: false
    t.string   "name_ua",    limit: 50, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name_en"], name: "index_vehicle_trademarks_on_name_en", unique: true, using: :btree
    t.index ["name_ua"], name: "index_vehicle_trademarks_on_name_ua", unique: true, using: :btree
  end

  create_table "vehicle_trim_levels", force: :cascade do |t|
    t.string   "name_en",          limit: 50, null: false
    t.string   "name_ua",          limit: 50, null: false
    t.integer  "vehicle_model_id",            null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["vehicle_model_id", "name_en"], name: "index_vehicle_trim_levels_on_vehicle_model_id_and_name_en", unique: true, using: :btree
    t.index ["vehicle_model_id", "name_ua"], name: "index_vehicle_trim_levels_on_vehicle_model_id_and_name_ua", unique: true, using: :btree
    t.index ["vehicle_model_id"], name: "index_vehicle_trim_levels_on_vehicle_model_id", using: :btree
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "vin",                        limit: 17
    t.integer  "vehicle_configuration_id",                              null: false
    t.integer  "vehicle_trademark_color_id",                            null: false
    t.boolean  "metallic",                              default: false, null: false
    t.integer  "fleet_id"
    t.integer  "vehicle_status_id",                                     null: false
    t.integer  "cost_centre_id"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "vehicle_registration_id"
    t.integer  "vehicle_inventory_id"
    t.index ["cost_centre_id"], name: "index_vehicles_on_cost_centre_id", using: :btree
    t.index ["fleet_id"], name: "index_vehicles_on_fleet_id", using: :btree
    t.index ["vehicle_configuration_id"], name: "index_vehicles_on_vehicle_configuration_id", using: :btree
    t.index ["vehicle_inventory_id"], name: "index_vehicles_on_vehicle_inventory_id", using: :btree
    t.index ["vehicle_registration_id"], name: "index_vehicles_on_vehicle_registration_id", using: :btree
    t.index ["vehicle_status_id"], name: "index_vehicles_on_vehicle_status_id", using: :btree
    t.index ["vehicle_trademark_color_id"], name: "index_vehicles_on_vehicle_trademark_color_id", using: :btree
    t.index ["vin"], name: "index_vehicles_on_vin", unique: true, where: "(vin IS NOT NULL)", using: :btree
  end

  create_table "waybills", force: :cascade do |t|
    t.string   "doc_no",          limit: 10, null: false
    t.date     "initial_date",               null: false
    t.date     "final_date",                 null: false
    t.integer  "vehicle_id",                 null: false
    t.integer  "initial_mileage",            null: false
    t.integer  "final_mileage",              null: false
    t.integer  "initial_fuel",               null: false
    t.integer  "final_fuel",                 null: false
    t.text     "comment"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["doc_no"], name: "index_waybills_on_doc_no", unique: true, using: :btree
    t.index ["vehicle_id"], name: "index_waybills_on_vehicle_id", using: :btree
  end

  add_foreign_key "engines", "engine_powers"
  add_foreign_key "engines", "fuel_brands"
  add_foreign_key "fuel_brands", "fuel_types"
  add_foreign_key "fuel_cards", "fuel_card_brands"
  add_foreign_key "fuel_checks", "fuel_brands"
  add_foreign_key "fuel_checks", "fuel_cards"
  add_foreign_key "fuel_checks", "vehicles"
  add_foreign_key "fuel_checks", "waybills"
  add_foreign_key "vehicle_bodyworks", "vehicle_categories"
  add_foreign_key "vehicle_bodyworks", "vehicle_mark_body_types"
  add_foreign_key "vehicle_bodyworks", "vehicle_models"
  add_foreign_key "vehicle_configurations", "engines"
  add_foreign_key "vehicle_configurations", "gearboxes"
  add_foreign_key "vehicle_configurations", "vehicle_bodyworks"
  add_foreign_key "vehicle_configurations", "vehicle_trim_levels"
  add_foreign_key "vehicle_inventories", "vehicles"
  add_foreign_key "vehicle_mark_body_types", "vehicle_body_types"
  add_foreign_key "vehicle_mark_body_types", "vehicle_trademarks"
  add_foreign_key "vehicle_models", "vehicle_groups"
  add_foreign_key "vehicle_models", "vehicle_trademarks"
  add_foreign_key "vehicle_registrations", "subjects", column: "vro_subject_id"
  add_foreign_key "vehicle_registrations", "vehicle_body_types"
  add_foreign_key "vehicle_registrations", "vehicle_registration_colors"
  add_foreign_key "vehicle_registrations", "vehicles"
  add_foreign_key "vehicle_trim_levels", "vehicle_models"
  add_foreign_key "vehicles", "cost_centres"
  add_foreign_key "vehicles", "fleets"
  add_foreign_key "vehicles", "vehicle_configurations"
  add_foreign_key "vehicles", "vehicle_inventories"
  add_foreign_key "vehicles", "vehicle_registrations"
  add_foreign_key "vehicles", "vehicle_statuses"
  add_foreign_key "vehicles", "vehicle_trademark_colors"
  add_foreign_key "waybills", "vehicles"
end
