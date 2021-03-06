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

ActiveRecord::Schema.define(version: 20161010130939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string   "title",                    null: false
    t.date     "date"
    t.integer  "plan_time"
    t.integer  "actual_time"
    t.text     "memo"
    t.integer  "importance",  default: 50
    t.integer  "urgency",     default: 50
    t.integer  "progress",    default: 0
    t.integer  "frequency",   default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "purpose",     default: 0,  null: false
    t.index ["date"], name: "index_tasks_on_date", using: :btree
    t.index ["frequency"], name: "index_tasks_on_frequency", using: :btree
    t.index ["progress"], name: "index_tasks_on_progress", using: :btree
  end

end
