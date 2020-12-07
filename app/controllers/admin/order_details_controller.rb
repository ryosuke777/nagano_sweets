class Admin::OrderDetailsController < ApplicationController

	def update
       order_detail = OrderDetail.find(params[:id])
       order_detail.update(order_detail_params)
       @order_details = OrderDetail.where(order_id: order_detail.order_id)

         if order_detail.making_status == "製作中"
           order_detail.order.status = "製作中"
           order_detail.order.save
         end

       @count = 0
         @order_details.each do |order_detail|
           if order_detail.making_status == "製作完了"
    	     @count += 1
           end
         end

           if @count == @order_details.count
      	     order_detail.order.status = "発送準備中"
             order_detail.order.save
           end

         redirect_to admin_order_path(order_detail.order.id)
	end





    private
    def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end

    def order_detail_params
      params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
    end

end
