module PostsHelper
  def youtube_video_id(url)
    # https://www.youtube.com/watch?v=XXXXXX や youtu.be/XXXXXX に対応
    uri = URI.parse(url)
    if uri.host.include?("youtu.be")
      uri.path[1..] # "/xxxxxx" → "xxxxxx"
    else
      Rack::Utils.parse_query(uri.query)["v"]
    end
  rescue
    nil
  end
end
