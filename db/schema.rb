# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100320195441) do

  create_table "black_hats", :force => true do |t|
    t.string   "text"
    t.integer  "sprint_id"
    t.integer  "promotions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "green_hats", :force => true do |t|
    t.string   "text"
    t.integer  "black_hat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner"
  end

  create_table "hats", :force => true do |t|
    t.text     "type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "green_hat_id"
    t.integer  "sprint_id"
  end

  create_table "sprints", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "encrypted_password",   :limit => 40, :null => false
    t.string   "password_salt",                      :null => false
    t.string   "confirmation_token",   :limit => 20
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token", :limit => 20
    t.string   "remember_token",       :limit => 20
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "yellow_hats", :force => true do |t|
    t.string   "text"
    t.integer  "sprint_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
