class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items  = Item.all
  end


 def show
    @item      = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres    = Genre.where(valid_invalid_status: 0)
 end
end
