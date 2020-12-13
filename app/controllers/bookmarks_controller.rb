class BookmarksController < ApplicationController

  def create
    bookmark = current_user.bookmarks.build(post_id: params[:post_id])
    bookmark.save!
    redirect_to posts_path
  end

  def destroy
    current_user.bookmarks.find_by(post_id: params[:post_id]).destroy!
    redirect_to posts_path
  end

end
