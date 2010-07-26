class Image < ActiveRecord::Base
  belongs_to :parent, :polymorphic => true

  has_attached_file :image,
    :styles => {
      :large => "1000x1000>",
      :medium => "300x300>",
      :thumb => "100x100#"
    },
    :url => "/store/:attachment/:id/:style/:basename.:extension",
    :path => ":rails_root/public/store/:attachment/:id/:style/:basename.:extension"
    # http://d.hatena.ne.jp/hichiriki/20081130 参照
end
