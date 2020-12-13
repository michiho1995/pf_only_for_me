class RelationshipsController < ApplicationController
  
  def follow
    current_user.follow(params[:following_id])
    redirect_to root_path
  end

  def unfollow
    current_user.unfollow(params[:following_id])
    redirect_to root_path
  end

  def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    redirect_back(fallback_location:root_path) #直前のビューページにリダイレクト
  end

  def destroy
    @user = Relationship.find(params[:id]).following
    current_user.unfollow!(@user)
    redirect_back(fallback_location:root_path) #直前のビューページにリダイレクト
  end

end
