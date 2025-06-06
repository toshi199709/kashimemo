let recorder;
let audioChunks = [];

window.startRecording = function () {
  navigator.mediaDevices.getUserMedia({ audio: true })
    .then(stream => {
      recorder = new MediaRecorder(stream);
      audioChunks = [];

      recorder.ondataavailable = event => {
        audioChunks.push(event.data);
      };

      recorder.onstop = async () => {
        const audioBlob = new Blob(audioChunks, { type: 'audio/webm' });
        const audioFile = new File([audioBlob], 'recording.webm');

        const formData = new FormData();
        formData.append('file', audioFile);

        try {
          const response = await fetch("https://whisper-api-26ac.onrender.com", {
            method: "POST",
            body: formData
          });

          const result = await response.json();
          const lyricsField = document.getElementById("lyrics_field");

          if (lyricsField) {
            lyricsField.value = result.text;
          } else {
            console.error("歌詞欄が見つかりませんでした");
          }
        } catch (error) {
          console.error("送信エラー:", error);
        }
      };

      recorder.start();
      console.log("🎙️ 録音開始！");
    })
    .catch(err => {
      console.error("マイクの取得に失敗:", err);
    });
};

window.stopRecording = function () {
  if (recorder && recorder.state !== "inactive") {
    recorder.stop();
    console.log("⏹️ 録音停止！");
  }
};
