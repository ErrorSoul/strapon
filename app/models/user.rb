class User < ActiveRecord::Base
  has_one :cart
  has_many :comments
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]
      user.image = auth["info"]["image"]
      
    end
  end

  def add_line_items_from_cart(cart)
    unless cart.line_items.empty?
      unless self.cart.line_items.empty?
        
        posts_ids = self.cart.line_items.map(&:post_id)
        cart.line_items.each do |x|
          unless posts_ids.include?(x.post_id)
            x.cart_id = nil
            self.cart.line_items << x 
          end
        
        end
      else
        self.cart = cart
      end
    end
    
  end

  def add_cart(cart)
    
    if self.cart.nil?
      self.cart = cart
    else
      self.add_line_items_from_cart(cart)
      Cart.destroy(cart.id)
      
      
    end
      
  end
end
