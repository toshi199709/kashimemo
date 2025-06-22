console.log("✅ playlist_modal_loader.js 読み込みOK");

import { Modal } from "bootstrap";

document.addEventListener("turbo:load", () => {
  const addButtons = document.querySelectorAll(".add-to-playlist-btn");

  addButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();

      const postId = button.dataset.postId;
      console.log(`🎵 モーダル開く post_id=${postId}`);

      const postIdField = document.getElementById("playlist_post_id");
      postIdField.value = postId;

      const playlistModal = new Modal(document.getElementById("playlistModal"));
      playlistModal.show();
    });
  });
});
