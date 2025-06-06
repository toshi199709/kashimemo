import sys
import yt_dlp
import os

def download_audio(youtube_url, output_path):
    # 例: /tmp/tmpabcdef.mp3 → 拡張子なしにして ffmpeg に変換してもらう
    temp_base = os.path.splitext(output_path)[0]

    ydl_opts = {
        'format': 'bestaudio/best',
        'outtmpl': temp_base + '.%(ext)s',  # 一時ファイル名に拡張子をつける
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
        'quiet': True,
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        ydl.download([youtube_url])

    # FFmpegで変換されたファイルが `temp_base.mp3` に出力されてるはず
    converted_path = temp_base + '.mp3'
    if os.path.exists(converted_path):
        os.rename(converted_path, output_path)
    else:
        raise Exception("MP3変換後のファイルが見つかりませんでした")

if __name__ == "__main__":
    youtube_url = sys.argv[1]
    output_path = sys.argv[2]
    download_audio(youtube_url, output_path)
