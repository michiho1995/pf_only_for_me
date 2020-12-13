class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }   #uniqueness: trueでモデルレベルで一意性(ユニーク)を保つ
end
