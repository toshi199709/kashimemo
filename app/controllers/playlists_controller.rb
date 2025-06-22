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
      if params[:post_id].present?
        PlaylistItem.create!(
          playlist: @playlist,
          post_id: params[:post_id],
          user_post_flag: current_user.posts.exists?(id: params[:post_id])
        )
      end

      respond_to do |format|
        format.js # ★ JS版で返す
        format.html { redirect_to posts_path, notice: "プレイリストを作成しました！" }
      end
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
