require 'rails_helper'

RSpec.describe '投稿機能', type: :system do
  include Devise::Test::IntegrationHelpers

  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'ログインして新規投稿できる' do
    user = FactoryBot.create(:user)
    sign_in user
    visit new_post_path

    fill_in 'post_title', with: 'システムテスト投稿'
    fill_in 'post_video_url', with: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
    fill_in 'post_lyrics', with: 'これはシステムテストの歌詞です'
    fill_in 'post_memo', with: 'これはシステムテストのメモです'
    check 'post_is_public'

    click_button '保存する'

    # 成功の検証（Flashがなくても大丈夫なように）
    expect(page).to have_content('システムテスト投稿')
    expect(page).to have_content('これはシステムテストの歌詞です')
  end
end
