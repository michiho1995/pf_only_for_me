class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    unless @post.favorited_by?(current_user)    #もしも、評価が偽(false)であれば・・する
      favorite = current_user.favorites.new(post_id: @post.id)
      favorite.save
      # redirect_back(fallback_location:root_path) #直前のビューページにリダイレクト
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    # redirect_back(fallback_location:root_path)
  end

end
