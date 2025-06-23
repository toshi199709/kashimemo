class PlaylistItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    post_id = params[:post_id]
    new_playlist_name = params[:new_playlist_name]
    existing_playlist_id = params[:existing_playlist_id]

    # 🎵 プレイリスト判定
    if new_playlist_name.present?
      playlist = current_user.playlists.create!(name: new_playlist_name)
    elsif existing_playlist_id.present?
      playlist = current_user.playlists.find(existing_playlist_id)
    else
      flash[:alert] = "プレイリストを選択するか、新規作成してください"
      respond_to do |format|
        format.js
        format.html { redirect_to posts_path, alert: "プレイリストを選択するか、新規作成してください" }
      end
      return
    end

    PlaylistItem.create!(
      playlist: playlist,
      post_id: post_id,
      user_post_flag: current_user.posts.exists?(id: post_id)
    )

    flash[:notice] = "プレイリストに追加しました！"

    respond_to do |format|
      format.js # ★ JSを返す（create.js.erb が動く）
      format.html { redirect_to posts_path, notice: "プレイリストに追加しました！" }
    end
  end
end
