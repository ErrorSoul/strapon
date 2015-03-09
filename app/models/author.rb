# == Schema Information
#
# Table name: authors
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  login           :string(255)
#  password_digest :string(255)
#  bio             :text
#  created_at      :datetime
#  updated_at      :datetime
#  remember_token  :string(255)
#  asset           :string(255)
#

class Author < ActiveRecord::Base
  before_create :create_remember_token
  has_many :posts
  has_secure_password
  validates :name, presence: true, length: { maximum: 24,
                                            minimum: 4 }

  validates :login, presence: true, uniqueness: true,
  length: {maximum: 12, minimum: 4 }
  
  validates :bio, presence: true, length: {maximum: 140}
  validates :password, length: {minimum: 6}
  mount_uploader :asset, AssetUploader
  


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
