class PostForm < BaseForm
  attr_accessor :title, :description, :city, :street, :house_number,
                :index_number, :floor, :rooms_count, :space, :build_year,
                :furniture, :fridge, :tv, :internet, :balcony, :conditioner,
                :home_id, :user, :photos, :price

  POST_FIELDS = %i[title description price].freeze
  HOUSE_FIELDS = %i[city street house_number index_number floor rooms_count
                    space build_year furniture fridge tv internet balcony
                    conditioner home_id user].freeze

  validates :title, :description, :city, :street, :house_number, :floor, :index_number, :rooms_count, presence: true,
            if: -> { true?(home_id) }
  validates :house_number, :floor, :index_number, :rooms_count, numericality: { only_integer: true },
            if: -> { true?(home_id) }

  protected

  def persist!
    home = find_or_initialize_home
    home.photos.attach(photos)
    home.save!

    Post.new(title: title, description: description, price: price, home: home, user: user).save!
  end

  def find_or_initialize_home
    if true?(home_id)
      Home.find(home_id)
    else
      Home.where(home_params).first_or_initialize
    end
  end

  def home_params
    (HOUSE_FIELDS - %i[home_id]).each_with_object({}) do |field, memo|
      memo[field] = try(field)
    end.compact
  end

  def true?(obj)
    obj&.downcase == "true"
  end
end