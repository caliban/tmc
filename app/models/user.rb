class User < ActiveRecord::Base
  before_save { email.downcase! }
  
  validates :first_name,    presence: true, length: { maximum: 25 }
  validates :last_name,     presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email,         presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :gender,        presence: true
  validates :date_of_birth, presence: true
  
  has_secure_password
  validates :password, length: { minimum: 10 }
end
