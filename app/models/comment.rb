class Comment < ActiveRecord::Base
  before_save :create_path
  after_save :add_child
  belongs_to :post
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  validates :name, :text, :post_id, presence: true
  default_scope -> { order('path ASC')}

  private
  
  def create_path
    puts "FFFFFF"
    @parent = Comment.find(self.commentable_id)
    self.path = convert_path(@parent.path, @parent.child)
    self.class_num = self.path.split(".").length 
  end

  def convert_child(child)
      if child.nil?
        return 0
      else
        return child
      end
  end
  
  def add_child
    @parent.update_column(:child, (convert_child(@parent.child + 1)))
  end
  
  def convert_path(parent_path, child)
    
    if parent_path.nil?
      first_part = ""
    else
      first_part = parent_path.to_s + "."
    end
    return first_part + (convert_child(child) + 1).to_s 
  end
end
