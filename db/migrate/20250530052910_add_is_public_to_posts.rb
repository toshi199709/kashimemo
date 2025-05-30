class AddIsPublicToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :is_public, :boolean
  end
end
