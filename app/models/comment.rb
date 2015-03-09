# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  text             :text
#  post_id          :integer
#  path             :string(255)
#  child            :integer          default(0)
#  class_num        :integer
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#

class Comment < ActiveRecord::Base
  before_save :create_path
  after_save :add_child
  belongs_to :user
  belongs_to :post
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  validates :text, :post_id, presence: true
  
  default_scope -> { order('path ASC')}
  


  def as_json(options={})
    super
  end
  private
  
  def create_path
    
    @parent = self.commentable_type.constantize.find(self.commentable_id)
    puts @parent.class.name, "PARENT_CLASS"
    
    self.path = convert_path(@parent.path, @parent.child)
    self.class_num = self.path.split(".").length 
  end

 
  
  def add_child
    
    @parent.update_column(:child, @parent.child + 1)
   
  end
  
  def convert_path(parent_path, child)
    puts "parent_path", parent_path
    if parent_path.nil?
      first_part = ""
    else
      first_part = parent_path.to_s + "."
    end
    return first_part + (child + 1).to_s 
  end
end
