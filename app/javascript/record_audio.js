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

      recorder.start();
      console.log("録音開始！");
    })
    .catch(err => {
      console.error("録音の取得に失敗:", err);
    });
};

window.stopRecording = function () {
  if (recorder && recorder.state !== "inactive") {
    recorder.stop();
    console.log("録音停止！");
  }
};
