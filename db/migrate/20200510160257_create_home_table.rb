class CreateHomeTable < ActiveRecord::Migration[6.0]
  def change
    create_table :homes do |t|
      t.string :city, null: false
      t.string :street, null: false
      t.string :house_number, null: false
      t.string :index_number
      t.string :floor
      t.string :rooms_count
      t.string :space
      t.date :build_year
      t.boolean :furniture, default: false
      t.boolean :fridge, default: false
      t.boolean :tv, default: false
      t.boolean :internet, default: false
      t.boolean :balcony, default: false
      t.boolean :conditioner, default: false
      t.bigint :user_id, default: false

      t.timestamps null: false
    end
  end
end
