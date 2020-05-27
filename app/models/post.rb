# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  description :string
#  price       :decimal(, )
#  status      :string           default("active"), not null
#  title       :string
#  views       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  home_id     :bigint
#  user_id     :integer          not null
#

class Post < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :home

  validates :description, :title, presence: true

  scope :active, -> { where(status: 'active') }
end
