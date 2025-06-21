class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_items, dependent: :destroy
  has_many :posts, through: :playlist_items
end
