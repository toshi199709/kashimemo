# app/controllers/users_controller.rb

class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit_background
    @user = current_user
  end

  def update_background
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: "背景を更新しました！"
    else
      render :edit_background
    end
  end

  def remove_background_image
    current_user.background_image.purge
    redirect_to edit_background_path, notice: "背景画像を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:background_image, :background_opacity)
  end
end
