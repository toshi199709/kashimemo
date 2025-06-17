class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '曲' },
    { id: 2, name: '趣味' },
    { id: 3, name: '勉強' },
    { id: 4, name: 'スポーツ' }
  ]

  include ActiveHash::Associations
  has_many :posts
end
