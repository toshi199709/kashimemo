console.log("✅ youtube_loader.js 実行開始！");

document.addEventListener("turbo:load", () => {
  const button = document.getElementById("load-video-btn");
  const input = document.getElementById("youtube-url");
  const iframe = document.getElementById("youtube-frame");
  const lyricsField = document.getElementById("lyrics_field");

  if (!button || !input || !iframe || !lyricsField) return;

  button.addEventListener("click", async (e) => {
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
    button.disabled = true;
    button.innerText = "読み込み中…";

    try {
      const res = await fetch("/posts/generate_lyrics", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ video_url: url })
      });

      const data = await res.json();
      console.log("🎤 取得したデータ:", data); // ← これ追加！
      lyricsField.value = data.lyrics;
    } catch (err) {
      console.error(err);
      alert("歌詞生成に失敗しました");
    } finally {
      button.disabled = false;
      button.innerText = "読み込む";
    }
  });

  function extractVideoId(url) {
    const reg = /(?:https?:\/\/)?(?:www\.)?youtu(?:be\.com\/watch\?v=|\.be\/)([a-zA-Z0-9_-]{11})/;
    const match = url.match(reg);
    return match ? match[1] : null;
  }
});
