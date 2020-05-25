class PostForm < BaseForm
  attr_accessor :title, :description, :city, :street, :house_number,
                :index_number, :floor, :rooms_count, :space, :build_year,
                :furniture, :fridge, :tv, :internet, :balcony, :conditioner,
                :home_id, :user, :avatar

  POST_FIELDS = %i[title description].freeze
  HOUSE_FIELDS = %i[city street house_number index_number floor rooms_count
                    space build_year furniture fridge tv internet balcony
                    conditioner home_id avatar user].freeze

  validates :title, :description, :city, :street, :house_number, :floor, :index_number, :rooms_count, presence: true,
            if: -> { home_id.nil? }
  validates :house_number, :floor, :index_number, :rooms_count, numericality: { only_integer: true },
            if: -> { home_id.nil? }

  protected

  def persist!
    home = find_or_initialize_home
    binding.pry
    home.save!

    Post.new(title: title, description: description, home: home, user: user).save!
  end

  def find_or_initialize_home
    if home_id
      Home.find(home_id)
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