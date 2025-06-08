require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts/new" do
    it "ログインしていないとログインページにリダイレクトされる" do
      get new_post_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "ログイン済みの場合" do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    it "新規投稿ページにアクセスできる" do
      get new_post_path
      expect(response).to have_http_status(:success)
    end

    it "自分の投稿であれば編集ページにアクセスできる" do
      post = FactoryBot.create(:post, user: @user)
      get edit_post_path(post)
      expect(response).to have_http_status(:success)
    end

    it "他人の投稿には編集ページにアクセスできず、リダイレクトされる" do
      other_user = FactoryBot.create(:user)
      other_post = FactoryBot.create(:post, user: other_user)

      get edit_post_path(other_post)
      expect(response).to redirect_to(root_path)
    end

    it "自分の投稿であれば削除できる" do
      post = FactoryBot.create(:post, user: @user)

      expect do
        delete post_path(post)
      end.to change(Post, :count).by(-1)
    end

    it "他人の投稿は削除できず、投稿数は変わらない" do
      other_user = FactoryBot.create(:user)
      other_post = FactoryBot.create(:post, user: other_user)

      expect do
        delete post_path(other_post)
      end.not_to change(Post, :count)

      expect(response).to redirect_to(root_path)
    end

    describe "投稿作成" do
      it "必要な情報が揃っていれば投稿できる" do
        post_params = {
          post: {
            title: "テスト投稿",
            video_url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            lyrics: "サンプル歌詞",
            memo: "サンプルメモ"
          }
        }

        expect do
          post posts_path, params: post_params
        end.to change(Post, :count).by(1)
      end

      it "titleが空では投稿できず、投稿数は変わらない" do
        post_params = {
          post: {
            title: "",
            video_url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            lyrics: "サンプル歌詞",
            memo: "サンプルメモ"
          }
        }

        expect do
          post posts_path, params: post_params
        end.not_to change(Post, :count)
      end
    end
  end
end
