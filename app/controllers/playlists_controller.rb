class PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @playlists = current_user.playlists
  end

  def new
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
