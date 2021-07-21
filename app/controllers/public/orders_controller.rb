class Public::OrdersController < ApplicationController
    
    def new
        @orders = Order.all
        @addresses = Address.all
    end
    
    def comfirm
        @cart_items = current_customer.cart_items
        @total = 0
      @cart_items.each do |cart_item| 
        total_amount = cart_item.price * cart_item.amount
        @total += total_amount
      end
      if session[:customer]["payment_method"] == "credit"
        @payment_method = "クレジット払い"
      elsif session[:customer]["payment_method"] == "bunk"
        @payment_method = "現金払い"
      end
    end
    
    def create
        session[:customer] = Order.new()
        
       if params[:payment_select] == "0"
         session[:customer][:payment_method] = 0
       elsif params[:payment_select] == "1"
         session[:customer][:payment_method] = 1
       end
    
       if params[:address_select] == "0"
         session[:customer][:postal_code] = current_customer.postal_code
         session[:customer][:address] = current_customer.address
         session[:customer][:name] = current_customer.last_name
       elsif params[:address_select] == "1"
         session[:customer][:postal_code] = Address.find(params[:address_id]).postal_code
         session[:customer][:address] = Address.find(params[:address_id]).address
         session[:customer][:name] = Address.find(params[:address_id]).name
       else 
         session[:customer][:postal_code] = params[:postal_code]
         session[:customer][:address] = params[:address]
         session[:customer][:name] = params[:name]
       end
         redirect_to comfirm_order_path(current_customer)
    end
    
    def index
         @orders = current_customer.order_ids
    end
    
    def show
        @order = Order.find(params[:id])
    end

    def complete
        order = Order.new(session[:user])
        order.postage = 500
        order.payment = 1000
        order.status = 1
        order.customer_id = current_customer.id
        order.save
        cart_items = current_customer_items
      cart_items.each do |cart_item|
        ordered_item = OrderedItem.new
        ordered_item.item_id = cart_item.item.id
        ordered_item.production_status = 0
        ordered_item.unit_price = cart_item.item.price
        ordered_item.quantity = cart_item.amount
        ordered_item.order_id = order.id
        ordered_item.save
      end
        cart_items.destroy_all
    end


  private

    def order_params
        params.require(:order).permit(:name, :postal_code, :address, :payment_method)
    end
    
    def cart_item_any?
       if current_end_user.cart_items.empty?
          redirect_to end_users_path
       end
    end
end
