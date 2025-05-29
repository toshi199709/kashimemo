module PostsHelper
  def youtube_embed_url(url)
    youtube_id = url.split("v=").last&.split("&")&.first
    "https://www.youtube.com/embed/#{youtube_id}" if youtube_id.present?
  end
end
