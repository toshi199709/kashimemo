class PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @playlists = current_user.playlists
  end

  def new
    @playlist = Playlist.new
    @post_id = params[:post_id]
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
