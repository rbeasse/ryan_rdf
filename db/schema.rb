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

ActiveRecord::Schema[7.0].define(version: 2023_01_19_023533) do
  create_table "graphs", force: :cascade do |t|
    t.string "name", null: false
    t.string "original_file", null: false
    t.datetime "generated_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "triples", force: :cascade do |t|
    t.string "subject", null: false
    t.string "object", null: false
    t.string "predicate", null: false
    t.integer "graph_id"
    t.index ["graph_id"], name: "index_triples_on_graph_id"
    t.index ["subject"], name: "index_triples_on_subject"
  end

end
