class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :video_url, presence: true
  validates :lyrics, presence: true
  validates :memo, presence: true
  validates :title, presence: true
end
