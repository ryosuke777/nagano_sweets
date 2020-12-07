class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  def total_count
  	count = 0
  	order_details.each do |order_detail|
  	 count += order_detail.amount
  	end
  	count
  end

end
