class Public::SessionsController < ApplicationController

  before_action :reject_user, only: [:create]


	def new
	end

	def create
	end

	def destroy
	end


  protected

  def reject_user
    @customer = Customer.find_by(email: params[:customer][:email].downcase)
    if @user
      if (@customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == false))
        flash[:error] = "退会済みです。"
        redirect_to new_customer_session_path
      end
    else
      flash[:error] = "必須項目を入力してください。"
    end
  end


end
