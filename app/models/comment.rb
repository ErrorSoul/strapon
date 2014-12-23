class Comment < ActiveRecord::Base
  belongs_to :post
  validates :name, :text, :post_id, :path, :class_num, presence: true
  default_scope -> { order('path ASC')}
end
