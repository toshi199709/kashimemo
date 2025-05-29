# app/helpers/application_helper.rb
module ApplicationHelper
  def youtube_embed_url(url)
    return "" if url.blank?

    uri = URI.parse(url)

    video_id =
      if uri.host.include?("youtu.be")
        uri.path.delete_prefix("/")
      elsif uri.host.include?("youtube.com")
        params = Rack::Utils.parse_nested_query(uri.query)
        params["v"]
      end

    "https://www.youtube.com/embed/#{video_id}" if video_id.present?
  rescue URI::InvalidURIError
    ""
  end
end
