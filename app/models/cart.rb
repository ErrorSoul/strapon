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

  def has_post(post)
    posts = line_items.includes(:post).map(&:post)
    flag, f_ind, b_ind = get_indexes(posts, post)
    return [flag, 
            (f_ind ? posts[f_ind].id : nil),
            (b_ind ? posts[b_ind].id : nil) ]
  end


  def get_indexes(arr, elem)
    # working on pair with line_items_length
    # working with array, who length >= 1
    len = arr.length 
    last = len - 1
    n = arr.index(elem)
    case n
      when nil
      #post is not arr, but arr is not empty
      # 0 is ind of first post in cart 
      return [nil, 0, nil]
      when 0
      return [0, arr[1] ? 1 : nil , nil]
      when last
      return [last, nil, arr[last - 1] ? last - 1 : nil]
    else
      return [n, n + 1, n - 1]
    end
  end
      

end
