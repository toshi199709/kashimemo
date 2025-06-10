require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end

  context '有効ないいねの場合' do
    it 'userとpostが紐づいていれば有効' do
      expect(@like).to be_valid
    end
  end

  context '無効な場合' do
    it 'userが紐づいていなければ無効' do
      @like.user = nil
      @like.valid?
      expect(@like.errors.full_messages).to include("User must exist")
    end

    it 'postが紐づいていなければ無効' do
      @like.post = nil
      @like.valid?
      expect(@like.errors.full_messages).to include("Post must exist")
    end

    it '同じユーザーが同じ投稿に2回いいねすることはできない' do
      @like.save # 1回目のいいね
      another_like = FactoryBot.build(:like, user: @like.user, post: @like.post)
      another_like.valid?
      expect(another_like.errors.full_messages).to include("User has already been taken")
    end
  end
end
