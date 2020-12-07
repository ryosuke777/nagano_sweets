class Admin::EndUsersController < ApplicationController

	def index
	  @customers = Customer.all
	end

	def show
      @customer = Customer.find(params[:id])
	end

	def edit
      @customer = Customer.find(params[:id])
	end

	def update
	  @customer = Customer.find(params[:id])
	  	 if @customer.update(customer_params)
           redirect_to "/admin/end_users/#{@customer.id}"
           # admin_item_path(@item.id)
         else
           redirect_to "/public/about"
         end
	end

    private
    def customer_params
      params.require(:customer).permit(:email, :first_name, :last_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number,:is_deleted)
    end

end
