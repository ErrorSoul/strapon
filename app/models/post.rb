# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  text        :text
#  author_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#  asset       :string(255)
#  child       :integer          default(0)
#  path        :string(255)
#  description :text
#  keywords    :text
#

class Post < ActiveRecord::Base
  belongs_to :user, class_name: "Author", foreign_key: 'author_id'
  belongs_to :author 
  validates :author_id, presence: true
  default_scope -> { order('created_at DESC')}
  validates :title, presence: true, length: {maximum: 140}
  validates :text, presence: true
  validates :description, :keywords, presence: true, length: {maximum: 140}
  
  #has_many :subs, class_name: "Comment", as: :commentable
  #has_many :comments, class_name: "Comment",foreign_key: "post_id"
  has_many :comments, as: :commentable
  has_many :line_items
  mount_uploader :asset, AssetUploader
  scope :perfect, -> { "Hirosima" }
  scope :all_public, -> { where(state: 'public') }
  after_save :to_draft 

  state_machine :state, initial: :new do
    event :public do 
      transition new: :public
    end

    event :new do
      transition public: :new
    end
  end

  private

  def to_draft
    new
  end
end
