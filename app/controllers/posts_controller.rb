class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order(created_at: :desc)
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


  def show
  @post = Post.find(params[:id])
  end


  private

  def post_params
    params.require(:post).permit(:video_url, :lyrics, :memo)
  end
end
