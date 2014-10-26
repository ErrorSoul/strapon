module SessionsHelper
  

  def sign_in(user)
    remember_token = Author.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Author.encrypt(remember_token))
    self.current_user = user 
    #pry.binding
  end
  
  def signed_in?
    !current_user.nil?
  end

  def sign_out 
    current_user.update_attribute(:remember_token,
                                  Author.encrypt(Author.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user?(user)
     user == current_user
  end

  def current_user=(user)
    @current_user = user 
  end

  def current_user
    remember_token = Author.encrypt(cookies[:remember_token])
    @current_user ||= Author.find_by(remember_token: remember_token)
  end

   
  def signed_in_user
    redirect_to admin_url unless signed_in?
  end

end
