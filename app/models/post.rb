# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  description :string
#  title       :string
#  views       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  home_id     :bigint
#  user_id     :integer          not null
#

class Post < ApplicationRecord
  belongs_to :user
  has_one :home

  validates :description, :title, presence: true
end
