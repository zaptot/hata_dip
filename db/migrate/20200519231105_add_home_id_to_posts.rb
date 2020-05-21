class AddHomeIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :home_id, :bigint
  end
end
