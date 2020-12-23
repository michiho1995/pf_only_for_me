class SearchController < ApplicationController

  def index
    @tag_list = Tag.all
    @posts = Post.page(params[:page]).reverse_order
    @post = current_user.posts.new
    @post_tags = @post.tags
    @user = User.all
  end

  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find_by(id: params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.present? ? @tag.posts : []         #クリックしたタグに紐付けられた投稿を全て表示

    if @range == '1'
      @user = User.search(search,word)
    else
      @post = Post.search(search,word, params[:color])
    end
    render template: "search/index" #直前のビューページにリダイレクト
  end

  def tag_search
    @range = '2'
    @tag_list = Tag.all
    @tag = Tag.find_by(id: params[:tag_id])  #クリックしたタグを取得
    if @tag.present?
      @post = @tag.posts
    else
      @post = []
    end       #クリックしたタグに紐付けられた投稿を全て表示
    @user = User.all
    render template: "search/index" #直前のビューページにリダイレクト
  end

  def post_params
    params.require(:post).permit(:title, :body, :tag, :red, :blue, :green, :pink, :white, :yellow, :gold, :silver, :black, :clear, :brown, post_images_images: [] )
  end

end
