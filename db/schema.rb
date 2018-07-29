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

ActiveRecord::Schema.define(version: 2018_07_20_084623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_categories", force: :cascade do |t|
    t.string "category_name"
    t.boolean "is_active"
  end

  create_table "course_details", force: :cascade do |t|
    t.integer "day_number", default: 0
    t.string "day_topic"
    t.string "day_details"
    t.integer "course_id"
    t.string "topic_image"
    t.string "topic_thumbnail"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "icon"
    t.integer "level"
    t.integer "instructor_id"
    t.integer "no_days"
    t.integer "category_id"
    t.string "course_image"
    t.string "course_thumbnail"
    t.boolean "is_active"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "faq_title"
    t.string "faq_description"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.string "role_description"
  end

  create_table "user_enrollments", force: :cascade do |t|
    t.integer "confirmation", default: 0
    t.string "notes"
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "is_active"
  end

  create_table "user_learnt_tracks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "day_number"
    t.integer "next_day_number"
    t.integer "course_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.boolean "is_active"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "user_image"
    t.string "password_digest"
    t.string "biography"
    t.boolean "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
