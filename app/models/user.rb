class User < ApplicationRecord
  has_many :courses

  attr_accessor :password, :password_confirmation

  validates :email, presence: true, uniqueness: true
  validates :password, length: { in: 7..255 }
  validate :passwords_are_equal, :valid_email

  def save
    if password
      write_attribute(:password_digest, PasswordSecurity.hash(password))
    end
    super
  end

  private

  def passwords_are_equal
    unless password == password_confirmation
      errors.add(:password_confirmation, "must be the same as password")
    end
  end

  def valid_email
    unless email =~ URI::MailTo::EMAIL_REGEXP
      errors.add(:email, "must be valid")
    end
  end
end
