class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :background_image

  validates :nickname, presence: true

  # ✅ 透過度（1〜100）バリデーションを追加
  validates :background_opacity,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 },
            allow_nil: true

  validate :password_complexity

  private

  def password_complexity
    return if password.blank?

    unless password.match?(/\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/)
      errors.add(:password, :invalid, message: "must include both letters and numbers")
    end
  end
end
