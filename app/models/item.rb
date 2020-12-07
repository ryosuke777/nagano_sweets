class Item < ApplicationRecord

  attachment :image
  belongs_to :genre, optional: true
  has_many :cart_items
  has_many :order_details
  validates :name, presence:true

end
