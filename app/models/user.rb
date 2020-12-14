class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy   #dependent: :destroyでユーザーが削除されたとき、そのユーザーに関連する情報を削除するよう紐付け
  has_many :post_comments, dependent: :destroy #コメント機能
  has_many :favorites, dependent: :destroy #いいね機能
  has_many :bookmarks, dependent: :destroy #ブックマーク機能
  has_many :bookmark_posts, through: :bookmarks, source: :post #has many throughオプションでユーザーがブックマークした投稿を直接アソシエーションで取得
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy #フォロワー
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy #フォロー
  has_many :followers, through: :follower_relationships
  has_many :tag_maps, dependent: :destroy #タグ一覧
  has_many :tags, through: :tag_maps  #タグ機能
  
  attachment :profile_image
  attachment :image

  validates :name, presence: true,
                   length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  def own_post?(post)
    self.id == post.user_id
  end
  
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end
  
  def self.search(search,word)
      if search == "forward_match"
        @user = User.where("name LIKE?","#{word}%")
      elsif search == "backward_match"
        @user = User.where("name LIKE?","%#{word}")
      elsif search == "perfect_match"
        @user = User.where("#{word}")
      elsif search == "partial_match"
        @user = User.where("name LIKE?","%#{word}%")
      else
        @user = User.all
      end
  end

end
