class Post < ActiveRecord::Base 
  include Voteable
  include Slug

	belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  validates :user, presence: true

  slugable_column :title

end