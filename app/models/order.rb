class Order < ApplicationRecord
  
  has_many :order_details
  has_many :items, through: :order_details
  
  belongs_to :customer
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def subtotal
    item.add_tax_price * amount
  end
  
end
