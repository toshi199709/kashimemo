# scripts/transcribe.py

import whisper
import sys

model = whisper.load_model("medium")  # tiny や base でもOK。用途に応じて調整可
audio_path = sys.argv[1]
result = model.transcribe(
    audio_path,
    language="ja",
    temperature=0.2
)

print(result["text"])
