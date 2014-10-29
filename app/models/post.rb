class Post < ActiveRecord::Base
  belongs_to :author
  validates :author_id, presence: true
  default_scope -> { order('created_at DESC')}
  validates :title, presence: true, length: {maximum: 140}
  validates :text, presence: true
  mount_uploader :asset, AssetUploader
end
