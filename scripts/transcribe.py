import whisper
import sys

model = whisper.load_model("base")  # tiny, base, medium など用途で変更可
audio_path = sys.argv[1]

result = model.transcribe(
    audio_path,
    language="ja",
    temperature=[0.2, 0.5],  # ← 複数温度で試行
    best_of=3,               # ← ベストの結果を選ぶ
    no_speech_threshold=0.5,
    logprob_threshold=-1.0,
    condition_on_previous_text=True,
    fp16=False               # CPU環境ではFalse推奨
)

print(result["text"])
