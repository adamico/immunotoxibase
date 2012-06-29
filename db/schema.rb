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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120618102656) do

  create_table "assessments", :force => true do |t|
    t.integer  "reference_id"
    t.integer  "molecule_id"
    t.integer  "measure_id"
    t.integer  "species_id"
    t.string   "condition"
    t.string   "effet"
    t.string   "level"
    t.integer  "evolution"
    t.integer  "old_id"
    t.datetime "maj"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "position"
  end

  add_index "assessments", ["measure_id"], :name => "index_assessments_on_measure_id"
  add_index "assessments", ["molecule_id"], :name => "index_assessments_on_molecule_id"
  add_index "assessments", ["reference_id"], :name => "index_assessments_on_reference_id"
  add_index "assessments", ["species_id"], :name => "index_assessments_on_species_id"

  create_table "measures", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "parent_id"
    t.integer  "old_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "measures", ["name"], :name => "index_measures_on_name", :unique => true
  add_index "measures", ["parent_id"], :name => "index_measures_on_parent_id"

  create_table "references", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.string   "source"
    t.string   "url"
    t.integer  "old_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "references", ["name"], :name => "index_references_on_name", :unique => true

  create_table "sections", :force => true do |t|
    t.string   "name",                 :null => false
    t.text     "description"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "parent_id"
    t.datetime "maj"
    t.string   "old_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "slug"
  end

  add_index "sections", ["name"], :name => "index_sections_on_name", :unique => true
  add_index "sections", ["parent_id"], :name => "index_sections_on_parent_id"
  add_index "sections", ["slug"], :name => "index_sections_on_slug", :unique => true

  create_table "species", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "old_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "species", ["name"], :name => "index_species_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
