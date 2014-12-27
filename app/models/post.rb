class Post < ActiveRecord::Base
  belongs_to :author
  validates :author_id, presence: true
  default_scope -> { order('created_at DESC')}
  validates :title, presence: true, length: {maximum: 140}
  validates :text, presence: true
  #has_many :subs, class_name: "Comment", as: :commentable
  #has_many :comments, class_name: "Comment",foreign_key: "post_id"
  has_many :comments, as: :commentable
  mount_uploader :asset, AssetUploader
end
