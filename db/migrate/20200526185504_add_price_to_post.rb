class AddPriceToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :price, :decimal
  end
end
