class Post < ApplicationRecord
  belongs_to :user

  validates :video_url, presence: true
  validates :lyrics, presence: true
  validates :memo, presence: true
end
