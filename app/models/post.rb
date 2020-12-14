class Post < ApplicationRecord
  belongs_to :user

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?      #ハッシュ形式でuser_id = user.id tureなら情報取得
  end

  # postのお気に入り判定 → vies側で呼び出し
  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?  #現在存在するタグの取得
    old_tags = current_tags - sent_tags  #古いタグの取得
    new_tags = sent_tags - current_tags  #新しいタグの取得

    old_tags.each do |old|
      self.post_tags.delete PostTag.find_by(tag_name: old)  #古いタグの削除
    end

    new_tags.each do |new|
      new_post_tag = PostTag.find_or_create_by(tag_name: new)  #新しいタグの保存
      self.post_tags << new_post_tag
    end
  end

  def self.search(search, word)
        if search == "forward_match"
          @post = Post.where("body LIKE?","#{word}%").where("red, blue, green, pink, white, yellow, gold, silver, black, clear","")
        elsif search == "backward_match"
          @post = Post.where("body LIKE?","%#{word}")
        elsif search == "perfect_match"
          @post = Post.where("#{word}")
        elsif search == "partial_match"
          @post = Post.where("body LIKE?","%#{word}%")
        else
          @post = Post.all
        end
  end

  accepts_attachments_for :post_images, attachment: :image

  validates :body, presence: true,
                   length: { maximum: 200 }

end
