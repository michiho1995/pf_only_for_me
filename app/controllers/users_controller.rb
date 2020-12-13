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
    @bookmarks = @user.bookmarks
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
     if  @user.update(user_params)
       flash[:notice] = 'You have updated successfully.'
         redirect_to user_path(@user.id)
     else
        render "edit"
     end
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end
end
