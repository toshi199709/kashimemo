# db/migrate/xxxx_add_likes_count_to_posts.rb
class AddLikesCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :likes_count, :integer, default: 0, null: false
  end
end
