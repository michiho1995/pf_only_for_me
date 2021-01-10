class Rgb < ApplicationRecord

  has_many :post_images, dependent: :destroy
  attachment :image

end
