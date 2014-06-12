class User < ActiveRecord::Base 
  include Slug
	has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, uniqueness: true, presence: true, length: {minimum: 3}
  validates :password, presence: true, length: {minimum: 3}, on: :create

  slugable_column :username

  def admin?
    self.role == "admin"  
  end

  

end