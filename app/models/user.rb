class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :nickname, presence: true

  validate :password_complexity

private

def password_complexity
  return if password.blank?

  unless password.match?(/\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/)
    errors.add(:password, :invalid, message: "must include both letters and numbers")
  end
end
end
