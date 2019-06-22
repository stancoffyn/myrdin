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

ActiveRecord::Schema.define(version: 20190621215209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apikeys", force: :cascade do |t|
    t.string "token"
    t.integer "auth_type"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_type"], name: "index_apikeys_on_auth_type"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.datetime "last_online"
    t.integer "character_class_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.index ["event_id"], name: "index_characters_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "event_name"
    t.datetime "scheduled_for"
    t.integer "created_by"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "character_id"
    t.index ["character_id"], name: "index_events_on_character_id"
  end

  add_foreign_key "characters", "events"
  add_foreign_key "events", "characters"
end
