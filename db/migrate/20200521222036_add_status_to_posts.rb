class AddStatusToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :status, :string, default: 'active', null: false
  end
end
