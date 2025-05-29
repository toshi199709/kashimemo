class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :preview]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]


def index
  @posts = Post.includes(:user).order(created_at: :desc)
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
    end



  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:video_url, :lyrics, :memo)
  end

  def authorize_user!
  @post = Post.find(params[:id])
  redirect_to root_path, alert: "不正なアクセスです" unless @post.user == current_user
  end
end

