class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  validates :video_url, presence: true
  validates :lyrics, presence: true
  validates :memo, presence: true
  validates :title, presence: true
  validates :category_id, numericality: { other_than: 0, message: "を選択してください" }
end
