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

ActiveRecord::Schema[7.0].define(version: 2023_09_10_112635) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_slots", force: :cascade do |t|
  end

  create_table "bookings", force: :cascade do |t|
    t.date "booking_date"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lesson_order_id", null: false
    t.index ["lesson_order_id"], name: "index_bookings_on_lesson_order_id"
  end

  create_table "lesson_orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "package"
    t.boolean "is_subscribed"
    t.integer "discount"
    t.index ["lesson_id"], name: "index_lesson_orders_on_lesson_id"
    t.index ["user_id"], name: "index_lesson_orders_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.float "price"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.index ["user_id"], name: "index_lessons_on_user_id"
  end

  create_table "slots", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.boolean "is_available"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "slot_booking_date"
    t.index ["lesson_id"], name: "index_slots_on_lesson_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.boolean "is_admin"
    t.string "address"
    t.boolean "subscribed"
    t.date "date_of_birth"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "lesson_orders"
  add_foreign_key "lesson_orders", "lessons"
  add_foreign_key "lesson_orders", "users"
  add_foreign_key "lessons", "users"
  add_foreign_key "slots", "lessons"
end
