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

ActiveRecord::Schema.define(version: 2020_07_11_125048) do

  create_table "deep_relationships", force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_deep_relationships_on_student_id"
    t.index ["teacher_id", "student_id"], name: "index_deep_relationships_on_teacher_id_and_student_id", unique: true
    t.index ["teacher_id"], name: "index_deep_relationships_on_teacher_id"
  end

  create_table "health_records", force: :cascade do |t|
    t.datetime "measured_at", null: false
    t.float "height"
    t.float "weight", null: false
    t.float "fat"
    t.float "muscle"
    t.integer "bmr"
    t.float "bmi"
    t.text "note"
    t.string "picture"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "measured_at"], name: "index_health_records_on_user_id_and_measured_at", unique: true
    t.index ["user_id"], name: "index_health_records_on_user_id"
  end

  create_table "meal_records", force: :cascade do |t|
    t.datetime "ate_at", null: false
    t.string "food"
    t.float "ate_gram"
    t.float "protein"
    t.float "fat"
    t.float "carbo"
    t.integer "calorie"
    t.integer "base_gram"
    t.text "note"
    t.string "picture"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "ate_at"], name: "index_meal_records_on_user_id_and_ate_at"
    t.index ["user_id"], name: "index_meal_records_on_user_id"
  end

  create_table "microposts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "content"
    t.integer "reply_id"
    t.integer "user_id"
    t.integer "micropost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id", "created_at"], name: "index_replies_on_micropost_id_and_created_at"
    t.index ["micropost_id"], name: "index_replies_on_micropost_id"
    t.index ["user_id", "created_at"], name: "index_replies_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.text "bio"
    t.string "url"
    t.string "tel"
    t.date "birthday"
    t.integer "gender"
    t.string "image_name"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
