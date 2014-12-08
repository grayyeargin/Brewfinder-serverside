class User < ActiveRecord::Base
  has_many :likes
  has_many :beers, through: :likes

  has_secure_password

  validates :first_name, :last_name, :presence => :true
  validates :username, uniqueness: true
  validates_format_of :username, :with => /\A[a-zA-Z0-9]+\z/
  validates_format_of :first_name, :last_name, :with => /\A[-a-zA-Z]+\z/
  validates :username, length: {minimum: 3}
  validates :password, length: {minimum: 6}
end
