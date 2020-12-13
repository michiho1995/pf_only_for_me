class Post < ApplicationRecord
  belongs_to :user

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?      #ハッシュ形式でuser_id = user.id tureなら情報取得
  end
  
  # postのお気に入り判定 → vies側で呼び出し
  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  accepts_attachments_for :post_images, attachment: :image

  validates :body, presence: true,
                   length: { maximum: 200 }

end
