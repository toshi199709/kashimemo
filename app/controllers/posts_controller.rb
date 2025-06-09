class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :preview]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @sort = params[:sort]

    if user_signed_in?
      base_scope = Post.includes(:user).where("is_public = ? OR posts.user_id = ?", true, current_user.id)
    else
      base_scope = Post.includes(:user).where(is_public: true)
    end

    @posts = case @sort
             when 'likes'
               base_scope.left_joins(:likes)
                         .group('posts.id')
                         .order('COUNT(likes.id) DESC')
             else
               base_scope.order(created_at: :desc)
             end
  end

  def new
    @post = Post.new
  end

  def edit
    session[:return_to] = request.referer
  end
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to posts_path, notice: '投稿を保存しました！'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to(session.delete(:return_to) || posts_path, notice: "編集が完了しました！")
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to(session.delete(:return_to) || posts_path, notice: "削除しました！")
  end

  def preview
    @post = Post.find(params[:id])
    unless @post.is_public || (user_signed_in? && current_user == @post.user)
      redirect_to root_path, alert: "この投稿は非公開です"
    end
  end

  def mypage
    @posts = current_user.posts.order(created_at: :asc)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :video_url, :lyrics, :memo, :is_public)
  end

  def authorize_user!
    @post = Post.find(params[:id])
    redirect_to root_path, alert: "不正なアクセスです" unless @post.user == current_user
  end
end
