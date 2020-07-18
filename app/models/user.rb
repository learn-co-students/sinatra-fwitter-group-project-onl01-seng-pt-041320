class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.split(" ")
    .join("-")
  end

  def self.find_by_slug(slug)
    self.all.find { |user| user.slug == slug }
  end

  
end