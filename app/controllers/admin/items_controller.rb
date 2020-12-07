class Admin::ItemsController < ApplicationController
	  before_action :authenticate_admin!
	  before_action :set_genres, only: [:index, :new, :edit, :create,:update]


	def index
     @items = Item.all
	end

	def new
	  @item = Item.new
	end

	def create
	  @item = Item.new(item_params)
	  if @item.save
	  	redirect_to admin_item_path(@item.id)
	  else
	  	redirect_to "/public/about"
	  end
	end

	def edit
	   @item = Item.find(params[:id])
	end

	def update
	   @item = Item.find(params[:id])
	     if @item.update(item_params)
           redirect_to admin_item_path(@item.id)
           # admin_item_path(@item.id)
         else
           render :edit
         end
	end

	def show
	   @item = Item.find(params[:id])
	end

	def destroy
	end

    private
    def item_params
      params.require(:item).permit(:name, :image, :introduction, :price, :genre_id, :is_active)
    end

    def set_genres
      @genres = Genre.all
    end

end
