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

end
