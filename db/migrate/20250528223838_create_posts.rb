class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :video_url
      t.text :lyrics
      t.text :memo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
