# scripts/download_audio.py

import sys
import os
import yt_dlp

def download_audio(url):
    os.makedirs("tmp", exist_ok=True)
    ydl_opts = {
        'format': 'bestaudio/best',
        'outtmpl': 'tmp/audio.%(ext)s',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
        'quiet': False,
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        ydl.download([url])

    print("✅ Downloaded audio to tmp/audio.mp3")

if __name__ == "__main__":
    url = sys.argv[1]
    download_audio(url)
