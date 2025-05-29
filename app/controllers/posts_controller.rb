class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

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

  def edit
  end

    def update
    if @post.update(post_params)
      redirect_to @post, notice: "編集が完了しました！"
    else
      render :edit
    end
    end

    def destroy
    @post.destroy
    redirect_to posts_path, notice: "削除しました！"
    end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:video_url, :lyrics, :memo)
  end
end
