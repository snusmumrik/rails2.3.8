class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string   :type                 # STI用
      t.string   :parent_type          # ポリモーフィック用type
      t.integer  :parent_id            # ポリモーフィック用id
      t.string   :image_file_name      # [Paperclip] (カラム名)_file_name
      t.string   :image_content_type   # [Paperclip] (カラム名)_content_type
      t.integer  :image_file_size      # [Paperclip] (カラム名)_file_size
      t.datetime :image_updated_at     # [Paperclip] (カラム名)_updated_at

      t.timestamps
      t.column :deleted_at, :datetime
    end
  end

  def self.down
    drop_table :images
  end
end
