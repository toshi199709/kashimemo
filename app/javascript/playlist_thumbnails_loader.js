console.log("✅ playlist_thumbnails_loader.js 読み込みOK");

document.addEventListener("turbo:load", () => {
  const thumbnailContainers = document.querySelectorAll(".playlist-thumbnails");

  thumbnailContainers.forEach((container) => {
    const images = container.querySelectorAll(".thumbnail-image");

    if (images.length === 1) {
      // 🎵 画像が1枚 → そのまま表示
      images[0].classList.add("active");
      return;
    }

    if (images.length <= 0) {
      // 🎵 画像なし → 何もしない
      return;
    }

    // 🎵 最初の画像に active をつける
    let currentIndex = 0;
    images[currentIndex].classList.add("active");

    setInterval(() => {
      // 🎵 次の index をランダムに選ぶ（今の index とは違うもの）
      let nextIndex;
      do {
        nextIndex = Math.floor(Math.random() * images.length);
      } while (nextIndex === currentIndex);

      // 🎵 切り替え
      images[currentIndex].classList.remove("active");
      images[nextIndex].classList.add("active");

      currentIndex = nextIndex;

    }, 6000); // 3秒ごと
  });
});
