# app/services/whisper_transcriber.rb
require 'httparty'

class WhisperTranscriber
  include HTTParty
  base_uri 'https://whisper-api-26ac.onrender.com'  # ← FastAPIのURL

  def self.call(video_url)
    response = post('/transcribe_url', body: { url: video_url })

    if response.success?
      JSON.parse(response.body)['text']
    else
      "文字起こしに失敗しました"
    end
  end
end
