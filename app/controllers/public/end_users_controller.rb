class Public::EndUsersController < ApplicationController

	def show
	  @customer = Customer.find(params[:id])
	end

	def edit
      @customer = Customer.find(params[:id])
	end

	def update
      @customer = Customer.find(params[:id])
      @customer.update(customer_params)
      redirect_to public_end_user_path
	end

	def unsubscribe
	end

	def withdraw
      @customer = current_customer
      @customer.is_deleted = true
      @customer.save
      reset_session
      flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
      redirect_to "/public"
	end

   def customer_params
      params.require(:customer).permit(:email, :name, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
   end


end
