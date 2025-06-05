class WhisperTranscriber
  def self.call(video_url)
    audio_path = "tmp/audio.mp3"

    # 1. YouTubeから音声をダウンロード
    system("python3 scripts/download_audio.py \"#{video_url}\"")

    # 2. ダウンロードした音声を30秒ごとに分割
    system("python3 scripts/split_audio.py #{audio_path}")

    # 3. 分割されたファイルを順番にWhisperへ渡して文字起こし
    full_output = ""
    Dir.glob("tmp/split/chunk_*.mp3").sort.each do |chunk_path|
      output = `python3 scripts/transcribe.py #{chunk_path}`
      full_output += output.strip + "\n"
    end

    # 4. 不要な繰り返しを少し整形
    cleaned = full_output.gsub(/^((.{2,10}・){5,})/) do |match|
      parts = match.split("・").reject(&:empty?)
      "#{parts.first(2).join('・')}・"
    end

    cleaned.strip
  end
end
