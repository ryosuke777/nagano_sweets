class Admin::OrdersController < ApplicationController

	def index
	  @orders = Order.all
	end

	def show
      @order = Order.find(params[:id])
      @order_details = OrderDetail.where(order_id: @order.id)
      @sum = 0
         @order_details.each do |order_detail|
           @sum += ((order_detail.item.price.to_i*1.10).floor)*order_detail.amount
         end
	end

	def update
      @order = Order.find(params[:id])
      @order_details = OrderDetail.where(order_id: @order.id)
      @order.update(order_params)

      if @order.status == "入金確認"
         @order_details.each do |order_detail|
         	order_detail.making_status = "製作待ち"
         	order_detail.save
         end
       end

       redirect_to admin_order_path(@order.id)
	end


    private
    def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end

    def order_detail_params
      params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
    end
end
