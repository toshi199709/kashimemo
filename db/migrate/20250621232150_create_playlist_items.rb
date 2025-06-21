class CreatePlaylistItems < ActiveRecord::Migration[7.1]
  def change
    create_table :playlist_items do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :lyrics
      t.text :memo
      t.boolean :user_post_flag

      t.timestamps
    end
  end
end
