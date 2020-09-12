class User < ApplicationRecord
  has_secure_password

  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 5 }, allow_blank: true
end
