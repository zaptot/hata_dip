class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :password_validation

  private

  def password_validation
    errors.add(:password, 'Password must by larger then 8 symbols') if password.size < 8
    errors.add(:password, 'Password must contain letters') if password !~ /[a-z]/
    errors.add(:password, 'Password must contain uppercase letters') if password !~ /[A-Z]/
  end
end
