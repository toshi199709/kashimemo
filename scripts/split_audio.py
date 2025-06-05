# scripts/split_audio.py
import sys
import os
import subprocess

def split_audio(input_path, segment_length=30):
    os.makedirs("tmp/split", exist_ok=True)
    cmd = [
        "ffmpeg",
        "-i", input_path,
        "-f", "segment",
        "-segment_time", str(segment_length),
        "-c", "copy",
        "tmp/split/chunk_%03d.mp3"
    ]
    subprocess.run(cmd, check=True)

if __name__ == "__main__":
    audio_path = sys.argv[1]
    split_audio(audio_path)
