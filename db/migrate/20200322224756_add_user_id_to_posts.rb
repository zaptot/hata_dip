class AddUserIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :user_id, :integer, null: false
    add_column :posts, :body, :string, null: false
  end
end
