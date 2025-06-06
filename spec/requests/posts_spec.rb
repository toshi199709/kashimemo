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
  end
end
