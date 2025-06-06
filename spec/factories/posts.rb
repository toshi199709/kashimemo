FactoryBot.define do
  factory :post do
    video_url { "https://www.youtube.com/watch?v=dQw4w9WgXcQ" }
    lyrics { "これはテスト用の歌詞です。" }
    memo { "これはテスト用のメモです。" }
    title { "テスト曲タイトル" }
    is_public { true }
    association :user
  end
end
