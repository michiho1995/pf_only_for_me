class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
      t.index [:user_id, :post_id], unique: true   #1人のユーザーが同じ投稿を複数回bookmarkできないようにすること
    end
  end
end
