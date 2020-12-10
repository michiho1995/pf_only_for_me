class UsersController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ

  def index
    @users = User.all
    @user = current_user
    @post = Post.new
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) if @user.id != current_user.id
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end
end
