class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :preview]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]


def index
  if user_signed_in?
    @posts = Post.includes(:user).where("is_public = ? OR user_id = ?", true, current_user.id).order(created_at: :desc)
  else
    @posts = Post.includes(:user).where(is_public: true).order(created_at: :desc)
  end
end



  def new
    @post = Post.new
  end

def create
  @post = Post.new(post_params)
  @post.user = current_user
  if @post.save
    redirect_to posts_path, notice: '投稿を保存しました！' # ← 一覧ページへリダイレクト
  else
    render :new
  end
end

  def edit
  end

def update
  if @post.update(post_params)
    redirect_to root_path, notice: "編集が完了しました！"
  else
    render :edit
  end
end

    def destroy
    @post.destroy
    redirect_to posts_path, notice: "削除しました！"
    end

def preview
  @post = Post.find(params[:id])
  unless @post.is_public || (user_signed_in? && current_user == @post.user)
    redirect_to root_path, alert: "この投稿は非公開です"
  end
end




  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:video_url, :lyrics, :memo, :is_public)
  end

  def authorize_user!
  @post = Post.find(params[:id])
  redirect_to root_path, alert: "不正なアクセスです" unless @post.user == current_user
  end
end

