class PostForm < BaseForm
  attr_accessor :title, :description, :city, :street, :house_number,
                :index_number, :floor, :rooms_count, :space, :build_year,
                :furniture, :fridge, :tv, :internet, :balcony, :conditioner,
                :house_id

  POST_FIELDS = %i[title description].freeze
  HOUSE_FIELDS = %i[city street house_number index_number floor rooms_count
                    space build_year furniture fridge tv internet balcony
                    conditioner].freeze

  validates :title, :description, :city, :street, :house_number, :floor, :index_number, :rooms_count, presence: true
  validates :house_number, :floor, :index_number, :rooms_count, numericality: { only_integer: true }

  protected

  def persist!
    find_or_initialize_home.save!
    Post.new(title: title, description: description, home: home).save!
  end

  def find_or_initialize_home
    if house_id
      Home.find(house_id)
    else
      Home.where(home_params).first_or_initialize
    end
  end

  def home_params
    HOUSE_FIELDS.each_with_object({}) do |field, memo|
      memo[field] = try(field)
    end.compact
  end
end