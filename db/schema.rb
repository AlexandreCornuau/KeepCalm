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

ActiveRecord::Schema[7.1].define(version: 2025_12_03_141837) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cases", force: :cascade do |t|
    t.string "name"
    t.string "gif_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "intervention_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intervention_id"], name: "index_chats_on_intervention_id"
  end

  create_table "daes", force: :cascade do |t|
    t.float "lat"
    t.float "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "street"
    t.string "postcode"
    t.string "city"
  end

  create_table "interventions", force: :cascade do |t|
    t.string "address"
    t.string "title"
    t.integer "age"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id", null: false
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_interventions_on_case_id"
    t.index ["user_id"], name: "index_interventions_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "role"
    t.string "content"
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  create_table "steps", force: :cascade do |t|
    t.text "details"
    t.string "picture_url"
    t.bigint "case_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "step_type"
    t.integer "number"
    t.index ["case_id"], name: "index_steps_on_case_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chats", "interventions"
  add_foreign_key "interventions", "cases"
  add_foreign_key "interventions", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "steps", "cases"
end
