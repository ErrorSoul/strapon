class Author < ActiveRecord::Base
  before_create :create_remember_token
  has_secure_password
  validates :name, presence: true, length: { maximum: 24,
                                            minimum: 4 }

  validates :login, presence: true, uniqueness: true,
  length: {maximum: 12, minimum: 4 }
  
  validates :bio, presence: true, length: {maximum: 140}
  validates :password, length: {minimum: 6}
  


  def Author.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Author.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  
  def create_remember_token
    self.remember_token = Author.encrypt(Author.new_remember_token)
  end

  
end
