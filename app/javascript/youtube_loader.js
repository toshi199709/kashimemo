document.addEventListener("turbo:load", () => {
  const button = document.getElementById("load-video-btn");
  const input = document.getElementById("youtube-url");
  const iframe = document.getElementById("youtube-frame");

  if (!button || !input || !iframe) return;

  button.addEventListener("click", (e) => {
    e.preventDefault();
    const url = input.value;
    const videoId = extractVideoId(url);
    if (videoId) {
      iframe.src = `https://www.youtube.com/embed/${videoId}`;
    } else {
      alert("正しいYouTubeのURLを入力してください");
    }
  });

  function extractVideoId(url) {
    const reg = /(?:https?:\/\/)?(?:www\.)?youtu(?:be\.com\/watch\?v=|\.be\/)([a-zA-Z0-9_-]{11})/;
    const match = url.match(reg);
    return match ? match[1] : null;
  }
});
