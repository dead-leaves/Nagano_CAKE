class Item < ApplicationRecord
  has_one_attached :image

  has_many :cart_items
  has_many :customers, through: :cart_items

  has_many :order_details
  has_many :orders, through: :order_details

  belongs_to :genre


  def add_tax_price
    (price * 1.1).floor
  end



  def get_image(width, height)
    unless image.attached?
     file_path = Rails.root.join('app/assets/images/C34455EA-2762-4966-93D1-F9254882B2A0_1_201_a.jpeg')
     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
