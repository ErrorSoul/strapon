class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :user
  

  def add_product(post_id)
    current_post = line_items.find_by(post_id: post_id)
    unless  current_post
      current_post = line_items.build(post_id: post_id)
    end
    current_post
  end

  def line_items_length
    len = line_items.length
    case len
    when 0
      return nil
      
    when 1
      return 0 
    
    else
      return 1
    end
  end

  def has_post?(post)
    posts = line_items.includes(:post).map(&:post)
    posts.include?(post)
  end
      

end
