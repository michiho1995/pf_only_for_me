class PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    #comment = current_user.post_comments.new(post_comment_params)
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.post_id = @post.id
    comment.save
    # redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    #comment = current_user.post_comments.find_by(post_comment_params)
    #comment.post_id = @post.id
    comment = current_user.post_comments.find(params[:id])
    comment.destroy
    #redirect_to post_path(params[:post_id])
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
