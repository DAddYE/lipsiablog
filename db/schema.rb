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

ActiveRecord::Schema.define(:version => 10) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "salt"
    t.string   "crypted_password"
    t.string   "role"
    t.string   "modules"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.string   "attached_file_name"
    t.string   "attached_content_type"
    t.integer  "attached_file_size"
    t.integer  "attacher_id"
    t.string   "attacher_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boxes", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "position",    :default => 0
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count", :default => 0
  end

  create_table "categories_posts", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "post_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.string   "description"
    t.string   "ip"
    t.boolean  "spam",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.text     "description_short"
    t.text     "description_long"
    t.string   "tags"
    t.integer  "menu",              :default => 0
    t.integer  "position",          :default => 0
    t.boolean  "commentable",       :default => true
    t.boolean  "draft",             :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",    :default => 0
  end

  create_table "settings", :force => true do |t|
    t.string  "name"
    t.string  "website"
    t.string  "email"
    t.string  "suffix"
    t.integer "menus",             :default => 1
    t.integer "page_limit",        :default => 5
    t.integer "feed_limit",        :default => 15
    t.boolean "feed_complete",     :default => false
    t.boolean "comments",          :default => true
    t.boolean "moderate_comments", :default => true
    t.text    "spam_black_list"
    t.integer "spam_max_links"
  end

  create_table "state_sessions", :force => true do |t|
    t.integer "account_id"
    t.string  "component",  :null => false
    t.text    "data"
  end

  add_index "state_sessions", ["component"], :name => "index_state_sessions_on_component"

end
