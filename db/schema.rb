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

ActiveRecord::Schema[7.1].define(version: 2024_01_08_131843) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fishes", force: :cascade do |t|
    t.string "name"
    t.integer "weight"
    t.integer "age"
    t.string "area"
    t.bigint "habitat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["age"], name: "index_fishes_on_age"
    t.index ["area"], name: "index_fishes_on_area"
    t.index ["habitat_id"], name: "index_fishes_on_habitat_id"
    t.index ["name", "weight"], name: "index_fishes_on_name_and_weight"
  end

  create_table "habitats", force: :cascade do |t|
    t.string "name"
    t.integer "max_deep"
    t.integer "fish_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
