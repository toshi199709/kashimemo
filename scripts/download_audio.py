# scripts/download_audio.py

import sys
import os
import yt_dlp

def download_audio(url, output_path="tmp/audio.mp3"):
    os.makedirs("tmp", exist_ok=True)
    ydl_opts = {
        'format': 'bestaudio/best',
        'outtmpl': output_path,
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
        'quiet': False,
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        ydl.download([url])

    print(f"Downloaded audio to {output_path}")

if __name__ == "__main__":
    url = sys.argv[1]
    download_audio(url)
