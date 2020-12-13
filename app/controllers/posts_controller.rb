class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = Post_comment.new
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
      if @post.user == current_user
        render "edit"
      else
        redirect_to posts_path
      end
  end


  def create
    @post = Post.new(post_params)   #データを新規登録するためのインスタンス作成
      @post.user_id = current_user.id

    if @post.save      #データをデータベースに保存するためのメソッド実行
      flash[:notice] = '投稿しました.'
        redirect_to post_path(@post.id)
    else
        render 'new'
    end

  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '更新しました'
      redirect_to post_path(@post.id)
    else
      render "edit"
    end

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = User.find([:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :introduction, :red, :blue, :green, :pink, :white, :yellow, :gold, :silver, :black, :clear, post_images_images: [] )
  end

end
