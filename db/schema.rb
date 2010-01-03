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

ActiveRecord::Schema.define(:version => 20100103041246) do

  create_table "blog_entries", :force => true do |t|
    t.integer  "blog_id"
    t.string   "title"
    t.text     "content",    :null => false
    t.string   "uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blog_entries", ["content"], :name => "fulltext_content"

  create_table "blogs", :force => true do |t|
    t.string   "author"
    t.string   "phonetic"
    t.string   "title"
    t.string   "uri"
    t.string   "tags"
    t.integer  "crawl_type",   :limit => 1
    t.integer  "delete_flg",   :limit => 1
    t.integer  "listed_count"
    t.datetime "last_update"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", :id => false, :force => true do |t|
    t.integer  "id",                        :default => 0, :null => false
    t.string   "name"
    t.string   "phonetic"
    t.integer  "category",     :limit => 1
    t.integer  "listed_count"
    t.integer  "delete_flg",   :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ng_words", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "blog_id"
    t.string   "ng_word"
    t.integer  "ng_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "blog_id"
    t.integer  "blog_entry_id"
    t.integer  "brand_id"
    t.integer  "product_id"
    t.integer  "delete_flg",    :limit => 1
    t.datetime "posted_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "uri"
    t.string   "image_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end