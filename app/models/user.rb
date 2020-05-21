# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :password_validation

  has_many :posts
  has_many :homes

  private

  def password_validation
    errors.add(:password, 'Password must by larger then 8 symbols') if password.size < 8
    errors.add(:password, 'Password must contain letters') if password !~ /[a-z]/
    errors.add(:password, 'Password must contain uppercase letters') if password !~ /[A-Z]/
  end
end
