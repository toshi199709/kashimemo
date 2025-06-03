# app/services/whisper_transcriber.rb

class WhisperTranscriber
  def self.call(video_url)
    audio_path = "tmp/audio.mp3"

    # 1. YouTubeから音声をダウンロード
    download_cmd = "python3 scripts/download_audio.py \"#{video_url}\""
    system(download_cmd)

    # 2. Whisperで文字起こし
    transcribe_cmd = "python3 scripts/transcribe.py #{audio_path}"
    output = `#{transcribe_cmd}`

    # 3. 結果（歌詞テキスト）を返す
    output.strip
  end
end
