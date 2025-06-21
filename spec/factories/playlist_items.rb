FactoryBot.define do
  factory :playlist_item do
    playlist { nil }
    post { nil }
    lyrics { "MyText" }
    memo { "MyText" }
    user_post_flag { false }
  end
end
