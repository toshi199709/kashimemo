let recorder;
let stream;
let isRecording = false;

window.startAutoRecording = async function () {
  try {
    stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    isRecording = true;
    recordLoop();  // 最初のループ開始
  } catch (err) {
    console.error("マイクの取得に失敗:", err);
  }
};

async function recordLoop() {
  if (!isRecording) return;

  recorder = new MediaRecorder(stream);
  let audioChunks = [];

  recorder.ondataavailable = event => {
    audioChunks.push(event.data);
  };

  recorder.onstop = async () => {
    const audioBlob = new Blob(audioChunks, { type: 'audio/webm' });
    const audioFile = new File([audioBlob], 'recording.webm');
    const formData = new FormData();
    formData.append('file', audioFile);

    try {
      const response = await fetch("https://whisper-api-stzu.onrender.com/transcribe", {
        method: "POST",
        body: formData
      });

      const result = await response.json();
      const lyricsField = document.getElementById("lyrics_field");

      if (lyricsField) {
        lyricsField.value += result.text + "\n";
      }
    } catch (error) {
      console.error("送信エラー:", error);
    }

    // 次の録音へ（前回の処理がすべて完了したら開始）
    if (isRecording) {
      setTimeout(recordLoop, 0); // すぐ次の録音へ
    }
  };

  recorder.start();
  setTimeout(() => recorder.stop(), 5000);
}

window.stopRecording = function () {
  isRecording = false;
  if (recorder && recorder.state !== "inactive") {
    recorder.stop();
  }
  if (stream) {
    stream.getTracks().forEach(track => track.stop());
  }
  console.log("⏹️ 自動録音停止！");
};
