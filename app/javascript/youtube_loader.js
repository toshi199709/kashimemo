console.log("✅ youtube_loader.js 実行開始！");

document.addEventListener("turbo:load", () => {
  const button = document.getElementById("load-video-btn");
  const input = document.getElementById("post_video_url");
  const iframe = document.getElementById("youtube-frame");

  if (!input || !iframe) return;

  // ⭐ 初期表示時にURLが入っていたら動画表示
  const initialUrl = input.value;
  const initialVideoId = extractVideoId(initialUrl);
  if (initialVideoId) {
    iframe.src = `https://www.youtube.com/embed/${initialVideoId}`;
  }

  // ⭐ ボタン押下時に動画を表示
  if (button) {
    button.addEventListener("click", (e) => {
      e.preventDefault();
      console.log("🎬 読み込みボタンがクリックされた");

      const url = input.value;
      const videoId = extractVideoId(url);

      console.log("🎯 入力されたURL:", url);
      console.log("🎯 抽出されたvideoId:", videoId);

      if (!videoId) {
        alert("正しいYouTubeのURLを入力してください");
        return;
      }

      iframe.src = `https://www.youtube.com/embed/${videoId}`;
    });
  }

  function extractVideoId(url) {
    const reg = /(?:https?:\/\/)?(?:www\.)?youtu(?:be\.com\/watch\?v=|\.be\/)([a-zA-Z0-9_-]{11})/;
    const match = url.match(reg);
    return match ? match[1] : null;
  }
});
