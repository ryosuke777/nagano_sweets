class Public::CartItemsController < ApplicationController

	def index
	  @cart_items = CartItem.all
    @sum = 0

	end


  def create
    @current_cart_items = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])
    if @current_cart_item.nil?
      @cart_item = current_customer.cart_items.new(cart_items_params)
    else
      @cart_item = @current_cart_items
      @cart_item.amount += params[:cart_item][:amount].to_i
    end

    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       @cart_item = @current_cart_items
       @cart_item.amount += params[:cart_item][:amount].to_i
    end

      @cart_item.save
      redirect_to "/public/cart_items"
  end

	def update
    cart_item = CartItem.find(params[:id])

      cart_item.update(cart_items_params)

    redirect_to public_cart_items_path
	end

	def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to public_cart_items_path
	end

	def delete_all
    @cart_items = CartItem.all
    @cart_items.destroy_all
    redirect_to public_cart_items_path
	end

	def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :genre_id, :is_active)
  end


  private

   def cart_items_params
      params.require(:cart_item).permit(:amount, :item_id)
   end


end
