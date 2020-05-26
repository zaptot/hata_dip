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
  include Filterable

  scope :filter_by_city, ->(city) { where(city: city) }
  scope :filter_by_street, ->(street) { where(street: street) }
  # scope :filter_by_build_year, ->(build_year) { where(city: build_year) }
  scope :filter_by_rooms_count, ->(rooms_count) { where(rooms_count: rooms_count) }
  scope :filter_by_floor, ->(floor) { where(floor: floor) }
  scope :filter_by_fridge, ->(fridge) { where(fridge: fridge) }
  scope :filter_by_furniture, ->(furniture) { where(furniture: furniture) }
  scope :filter_by_internet, ->(internet) { where(internet: internet) }
  scope :filter_by_conditioner, ->(conditioner) { where(conditioner: conditioner) }
  scope :filter_by_balcony, ->(balcony) { where(balcony: balcony) }
  scope :filter_by_tv, ->(tv) { where(tv: tv) }

  has_many_attached :photos

  belongs_to :user
  has_many :posts

  private

  def search_by_full_address(full_adress)
    {
      house_number: full_adress.split('/').first,
      index_number: full_adress.split('/').last
    }
  end
end
