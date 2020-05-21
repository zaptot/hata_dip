# == Schema Information
#
# Table name: homes
#
#  id           :bigint           not null, primary key
#  balcony      :boolean          default(FALSE)
#  build_year   :date
#  city         :string           not null
#  conditioner  :boolean          default(FALSE)
#  floor        :string
#  fridge       :boolean          default(FALSE)
#  furniture    :boolean          default(FALSE)
#  house_number :string           not null
#  index_number :string
#  internet     :boolean          default(FALSE)
#  rooms_count  :string
#  space        :string
#  street       :string           not null
#  tv           :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           default(0)
#

class Home < ApplicationRecord
  belongs_to :user
  has_many :posts
end
