class Public::OrdersController < ApplicationController

	def new
	 @order = Order.new
     @order.customer_id = current_customer.id
	end

	def confirm
      @order = Order.new
      @order.customer_id = current_customer.id
      @order.shipping_cost = params[:order][:shipping_cost]
      @order.status = 0
      @cart_items = CartItem.all

      @sum = 0
        @cart_items.each do |cart_item|
          @sum += (cart_item.item.price.to_i*1.10).floor * (cart_item.amount.to_i)
        end

	   if  params[:order][:address_option] == "0"
	   	 @order.address = current_customer.address
	   	 @order.postal_code = current_customer.postal_code
	   	 @order.name = (current_customer.last_name + current_customer.first_name)
	   elsif params[:order][:address_option] == "1"
       @address = Address.find(params[:order][:id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
	   elsif params[:order][:address_option] == "2"
	     # @order = Order.new(order_params)
       @address = Address.new
       @address.customer_id = current_customer.id
       @address.address = params[:order][:address]
       @address.postal_code = params[:order][:postal_code]
       @address.name = params[:order][:name]
       @address.save

       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name

	   end

	   if  params[:order][:payment_method_option] == "0"
	   	@order.payment_method = 0
	   elsif params[:order][:payment_method_option] == "1"
	   	@order.payment_method = 1
	   end

	end

	def create
	    @order = Order.new(order_params)
	    if @order.save
          # @order_detail = OrderDetail.new
          # @order_detail.order_id = @order.id
          @cart_items = CartItem.where(customer_id: current_customer.id)
          @cart_items.each do |cart_item|
          	@order_detail = OrderDetail.new
            @order_detail.order_id = @order.id
          	@order_detail.item_id = cart_item.item_id
           	@order_detail.price = cart_item.item.price
          	@order_detail.amount = cart_item.amount
            @order_detail.making_status = 0
            @order_detail.save



       # @address = Address.new
       # @address.customer_id = current_customer.id
       # @address.address = @order.address
       # @address.postal_code = @order.postal_code
       # @address.name = @order.name
       # @address.save

            cart_item.destroy
          end
          # binding.pry
          redirect_to public_orders_thanks_path
		end
	end

	def thanks
	end

	def index
      @customer = current_customer
      @orders = Order.all
      @order_details = OrderDetail.all
	end

	def show
      @order = Order.find(params[:id])
      @order_details = OrderDetail.where(order_id: @order.id)
      @sum = 0
         @order_details.each do |order_detail|
           @sum += ((order_detail.item.price.to_i*1.10).floor)*order_detail.amount
         end
	end

    private
    def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end

    # def address_params
    #   params.require(:address).permit(:customer_id, :name, :postal_code, :address)
    # end
    # def order_detail_params
    #   params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
    # end

end
