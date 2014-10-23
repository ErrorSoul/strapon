include ApplicationHelper

def sign_in(user)
    # Sign in when not using Capybara.
    remember_token = Author.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, Author.encrypt(remember_token))
  
end
