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

  // 🎵 ★ 作成フォームsubmit成功時にモーダルを閉じる
  const createForm = document.querySelector("#playlist-create-form");
  if (createForm) {
    createForm.addEventListener("ajax:success", (event) => {
      console.log("✅ プレイリスト作成成功 → モーダル閉じる");

      const modalElement = document.getElementById("playlistModal");
      const modalInstance = Modal.getInstance(modalElement);
      modalInstance.hide();
    });

    createForm.addEventListener("ajax:error", (event) => {
      console.log("⚠️ プレイリスト作成失敗", event);
    });
  }

  // 🎵 ★ 追加フォームsubmit成功時にモーダルを閉じる
  const addForm = document.querySelector("#playlist-add-form");
  if (addForm) {
    addForm.addEventListener("ajax:success", (event) => {
      console.log("✅ プレイリスト追加成功 → モーダル閉じる");

      const modalElement = document.getElementById("playlistModal");
      const modalInstance = Modal.getInstance(modalElement);
      modalInstance.hide();
    });

    addForm.addEventListener("ajax:error", (event) => {
      console.log("⚠️ プレイリスト追加失敗", event);
    });
  }
});
