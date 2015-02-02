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

ActiveRecord::Schema.define(version: 20150202180808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "score_types", force: :cascade do |t|
    t.string "sa_objective_code"
    t.string "description"
    t.string "assumptions"
    t.text   "scoring_descriptions"
  end

  add_index "score_types", ["sa_objective_code"], name: "index_score_types_on_sa_objective_code", unique: true, using: :btree

  create_table "scores", force: :cascade do |t|
    t.string  "shlaa_ref"
    t.string  "score"
    t.integer "site_id"
    t.integer "score_type_id"
  end

  add_index "scores", ["shlaa_ref"], name: "index_scores_on_shlaa_ref", using: :btree
  add_index "scores", ["site_id", "score_type_id"], name: "index_scores_on_site_id_and_score_type_id", unique: true, using: :btree

  create_table "sites", force: :cascade do |t|
    t.string  "shlaa_ref"
    t.string  "address"
    t.float   "area_ha"
    t.integer "capacity"
    t.string  "io_rag"
    t.string  "settlement_hierarchy"
    t.string  "green_brown"
    t.string  "reason"
  end

  add_index "sites", ["shlaa_ref"], name: "index_sites_on_shlaa_ref", unique: true, using: :btree

end
