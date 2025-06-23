class PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @playlists = current_user.playlists
  end

  def show
    @playlist = current_user.playlists.find(params[:id])
    @playlist_items = @playlist.playlist_items.includes(:post)
  end

  def new
    @playlist = Playlist.new
    @post_id = params[:post_id]
  end

  def edit
  end

  def create
    @playlist = current_user.playlists.build(playlist_params)

    if @playlist.save
      flash[:notice] = "プレイリストを作成しました！"
      respond_to do |format|
        format.js # 作成モーダル用
        format.html { redirect_to posts_path, notice: "プレイリストを作成しました！" }
      end
    else
      flash[:alert] = "プレイリストの作成に失敗しました"
      respond_to do |format|
        format.js
        format.html { redirect_to posts_path, alert: "プレイリストの作成に失敗しました" }
      end
    end
  end

  def update
  end

  def destroy
    playlist = current_user.playlists.find(params[:id])
    playlist.destroy

    flash[:notice] = "プレイリストを削除しました！"
    redirect_to mypage_path
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
