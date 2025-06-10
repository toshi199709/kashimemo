class UsersController < ApplicationController
  before_action :authenticate_user!

  def update_background
    @user = current_user

    if params[:remove_background]
      @user.background_image.purge
      flash[:notice] = "背景画像を削除しました。"
      redirect_to mypage_path and return
    end

    if @user.update(user_params)
      redirect_to mypage_path, notice: "背景を更新しました！"
    else
      flash.now[:alert] = "背景の更新に失敗しました。"
      render :mypage
    end
  end

  private

  def user_params
    params.require(:user).permit(:background_image, :background_opacity)
  end
end
