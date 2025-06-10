require 'rails_helper'

RSpec.describe "Likes", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end

  context "ログインしている場合" do
    before do
      sign_in @user
    end

    it "投稿にいいねできる" do
      expect do
        post post_likes_path(@post)
      end.to change(Like, :count).by(1)
    end

    it "投稿のいいねを解除できる" do
      like = FactoryBot.create(:like, user: @user, post: @post)

      expect do
        delete post_like_path(@post, like)
      end.to change(Like, :count).by(-1)
    end
  end

  context "ログインしていない場合" do
    it "いいねしようとするとログインページにリダイレクトされる" do
      post post_likes_path(@post)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "いいね解除しようとするとログインページにリダイレクトされる" do
      like = FactoryBot.create(:like, post: @post, user: @user)
      delete post_like_path(@post, like)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
