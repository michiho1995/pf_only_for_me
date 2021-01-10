class PostImage < ApplicationRecord

  belongs_to :post
  attachment :image
  belongs_to :rgb, optional: true

end
