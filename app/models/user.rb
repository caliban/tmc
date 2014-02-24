class User < ActiveRecord::Base
  before_save { email.downcase! }
  before_create :create_remember_token
  
  VALID_NAME_REGEX = /\A[A-Z][a-z]+([-][A-Z][a-z]+)*\z/x
  validates :first_name,    presence: true, length: { maximum: 25 }, format: { with: VALID_NAME_REGEX }
  validates :last_name,     presence: true, length: { maximum: 25 }, format: { with: VALID_NAME_REGEX }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email,         presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  VALID_GENDER_REGEX = /\A(male|female)\z/
  validates :gender,        presence: true, format: { with: VALID_GENDER_REGEX }
  
  validates :date_of_birth, presence: true
  
  has_secure_password
  validates :password, length: { minimum: 10 }
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
