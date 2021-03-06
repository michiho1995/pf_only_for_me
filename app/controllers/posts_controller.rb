class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.page(params[:page])
    @post = current_user.posts.new   #ビューのform_withのmodelに使う。
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def show
    @post = Post.find(params[:id])  #クリックした投稿を取得。
    @post_tags = @post.tags         #そのクリックした投稿に紐付けられているタグの取得。
    @post_comment = PostComment.new
    @user = User.find(@post.user_id)

    @rgbs = Rgb.where(post_image_id: @post.post_image_ids)
    #@rgbs = Rgb.all
    #@rgbs = @post.post_images.rgbs
    # @rgbs = []
    # @post.post_images.each do |image|
    #   if image.rgb.present?
    #     @rgbs << image.rgb
    #   end
    # end
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
    # @post = Post.new(post_params)   #データを新規登録するためのインスタンス作成
    #   @post.user_id = current_user.id

    @post = current_user.posts.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(nil)  #送信されてきたタグの取得  #.split(nil)：送信されてきた値を、スペースで区切って配列化

    if  @post.save      #データをデータベースに保存するためのメソッド実行

      @post.post_images.each do |post_image|

        Vision.get_image_data(post_image.image).each do |rgb|
            Rgb.new(rgb.merge({post_image_id: post_image.id})).save
            #post_image.rgb.new(rgb).save
        end
      end

        @post.save_tag(tag_list)
        redirect_to post_path(@post.id)
    else
        render 'new'
    end

  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
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

  def search
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
  end

  def bookmarks
    @posts = current_user.bookmark_posts.includes(:user).recent
  end

  def post_params
    params.require(:post).permit(:title, :body, :tag, :red, :blue, :green, :pink, :white, :yellow, :gold, :silver, :black, :clear, :brown, post_images_images: [] )
  end

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

end
