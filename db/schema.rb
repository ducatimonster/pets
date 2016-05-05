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

ActiveRecord::Schema.define(version: 20160419061909) do

  create_table "authorized_people", force: :cascade do |t|
    t.string   "full_name"
    t.string   "authorized_person_telephone"
    t.integer  "client_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "authorized_people", ["client_id"], name: "index_authorized_people_on_client_id"

  create_table "breeds", force: :cascade do |t|
    t.string   "breed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_pets", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "pet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "client_pets", ["client_id"], name: "index_client_pets_on_client_id"
  add_index "client_pets", ["pet_id"], name: "index_client_pets_on_pet_id"

  create_table "clients", force: :cascade do |t|
    t.string   "client_first_name"
    t.string   "client_last_name"
    t.string   "client_email"
    t.string   "client_telephone"
    t.string   "client_emergency_telephone"
    t.string   "client_address"
    t.boolean  "client_status"
    t.boolean  "allow_contact"
    t.string   "referred"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string   "color_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_services", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "service_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "employee_services", ["employee_id"], name: "index_employee_services_on_employee_id"
  add_index "employee_services", ["service_id"], name: "index_employee_services_on_service_id"

  create_table "employees", force: :cascade do |t|
    t.string   "employee_first_name"
    t.string   "employee_last_name"
    t.string   "emergency_contact_number"
    t.boolean  "employee_status"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "grooming_services", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "grooming_id"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "employee_id"
  end

  add_index "grooming_services", ["employee_id"], name: "index_grooming_services_on_employee_id"
  add_index "grooming_services", ["grooming_id"], name: "index_grooming_services_on_grooming_id"
  add_index "grooming_services", ["service_id"], name: "index_grooming_services_on_service_id"

  create_table "groomings", force: :cascade do |t|
    t.date     "date"
    t.time     "arrival_time"
    t.datetime "pickup_time"
    t.boolean  "fleas_ticks"
    t.boolean  "matted_tangled"
    t.integer  "pet_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "groomings", ["pet_id"], name: "index_groomings_on_pet_id"

  create_table "incidents", force: :cascade do |t|
    t.date     "incident_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "incident_description"
  end

  create_table "note_types", force: :cascade do |t|
    t.string   "note_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text     "note_description"
    t.string   "note_importance"
    t.integer  "note_type_id"
    t.integer  "pet_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "notes", ["note_type_id"], name: "index_notes_on_note_type_id"
  add_index "notes", ["pet_id"], name: "index_notes_on_pet_id"

  create_table "pages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pet_breeds", force: :cascade do |t|
    t.integer  "pet_id"
    t.integer  "breed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pet_breeds", ["breed_id"], name: "index_pet_breeds_on_breed_id"
  add_index "pet_breeds", ["pet_id"], name: "index_pet_breeds_on_pet_id"

  create_table "pet_image_repos", force: :cascade do |t|
    t.integer  "pet_id"
    t.string   "comment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "pet_image_repos", ["pet_id"], name: "index_pet_image_repos_on_pet_id"

  create_table "pet_incidents", force: :cascade do |t|
    t.integer  "pet_id"
    t.integer  "incident_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "pet_incidents", ["incident_id"], name: "index_pet_incidents_on_incident_id"
  add_index "pet_incidents", ["pet_id"], name: "index_pet_incidents_on_pet_id"

  create_table "pets", force: :cascade do |t|
    t.string   "pet_name"
    t.date     "pet_dob"
    t.string   "pet_gender"
    t.integer  "color_id"
    t.text     "pet_markings"
    t.boolean  "pet_status_inactive"
    t.boolean  "pet_disclosure"
    t.boolean  "is_spay_neutered"
    t.integer  "client_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
  end

  add_index "pets", ["client_id"], name: "index_pets_on_client_id"
  add_index "pets", ["color_id"], name: "index_pets_on_color_id"

  create_table "services", force: :cascade do |t|
    t.string   "service_description"
    t.string   "service_name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "service_status_inactive"
  end

  create_table "shot_records", force: :cascade do |t|
    t.integer  "vaccination_id"
    t.date     "shot_date"
    t.date     "shot_expiration"
    t.integer  "pet_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "shot_records", ["pet_id"], name: "index_shot_records_on_pet_id"
  add_index "shot_records", ["vaccination_id"], name: "index_shot_records_on_vaccination_id"

  create_table "vaccinations", force: :cascade do |t|
    t.string   "vaccination_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
