require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  context '投稿できる場合' do
    it 'video_url, lyrics, memo, title, userが存在すれば投稿できる' do
      expect(@post).to be_valid
    end
  end

  context '投稿できない場合' do
    it 'video_urlが空では投稿できない' do
      @post.video_url = ''
      @post.valid?
      expect(@post.errors.full_messages).to include("Video url can't be blank")
    end

    it 'lyricsが空では投稿できない' do
      @post.lyrics = ''
      @post.valid?
      expect(@post.errors.full_messages).to include("Lyrics can't be blank")
    end

    it 'memoが空では投稿できない' do
      @post.memo = ''
      @post.valid?
      expect(@post.errors.full_messages).to include("Memo can't be blank")
    end

    it 'titleが空では投稿できない' do
      @post.title = ''
      @post.valid?
      expect(@post.errors.full_messages).to include("Title can't be blank")
    end

    it 'userが紐づいていなければ投稿できない' do
      @post.user = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("User must exist")
    end
  end

  describe 'アソシエーションのテスト' do
    it 'postを削除すると関連するlikeも削除される' do
      post = FactoryBot.create(:post)
      user = FactoryBot.create(:user)
      FactoryBot.create(:like, user: user, post: post)

      expect { post.destroy }.to change { Like.count }.by(-1)
    end
  end
end
