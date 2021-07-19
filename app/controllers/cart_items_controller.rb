class CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end

  def new
	  @order_history = OrderHistory.new
	  @new_address   = ShippingAddress.new
  end

  def create
    if current_customer.cart_items.where(itrm_id: params[:cart_item][:item_id].to_i).enpty?
      @cart_item             = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
    else
      @cart_item = current_customer.cart_items.find_by(item_id :params[:cart_item][:item_id].to_i)
      @cart.update(nunber: params[:cart_item][:number].to_i+@cart.number)
    end
    redirect_to items_path
  end
  
  
end
