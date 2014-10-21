class Author < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, length: { maximum: 24,
                                            minimum: 4 }

  validates :login, presence: true, uniqueness: true,
  length: {maximum: 12, minimum: 4 }
  
  validates :bio, presence: true, length: {maximum: 140}
  validates :password, length: {minimum: 6}
  
  
end
