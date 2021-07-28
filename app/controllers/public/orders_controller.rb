class Public::OrdersController < ApplicationController

    def new
        @orders    = Order.all
        @customer  = current_customer
        @addresses = @customer.addresses.all
    end

    def comfirm
      @cart_items  = current_customer.cart_items
      @total       = 0
      @cart_items.each do |cart_item|
        total_amount = (cart_item.item.price * cart_item.amount*1.1).round
        @total      += total_amount
      end
      session[:customer]                 = current_customer.orders.build
      session[:customer][:total_payment] = @total+800
       if params[:payment_select] == "1"
         session[:customer][:payment_method] = 1
       elsif params[:payment_select] == "2"
         session[:customer][:payment_method] = 2
       end

       if params[:address_select] == "0"
         session[:customer][:postal_code] = current_customer.postal_code
         session[:customer][:address]     = current_customer.address
         session[:customer][:name]        = current_customer.last_name
       elsif params[:address_select] == "1"
         session[:customer][:postal_code] = Address.find(params[:address_id]).postal_code
         session[:customer][:address]     = Address.find(params[:address_id]).address
         session[:customer][:name]        = Address.find(params[:address_id]).name
       else
         session[:customer][:postal_code] = params[:postal_code]
         session[:customer][:address]     = params[:address]
         session[:customer][:name]        = params[:name]
       end
    end

    def create
         @order               = Order.new(session[:customer])
         @order.customer_id   = current_customer.id
         @cart_items          = current_customer.cart_items
         @order.shipping_cost = 800
         @order.save
         @cart_items.each do |cart_item|
             @order_detail               = OrderDetail.new
             @order_detail.item_id       = cart_item.item_id
             @order_detail.making_status = 0
             @order_detail.price         = cart_item.item.price
             @order_detail.amount        = cart_item.amount
             @order_detail.order_id      = @order.id
             @order_detail.save
          end
        current_customer.cart_items.destroy_all
        session.delete(:customer)
        redirect_to complete_orders_path
    end

    def index
        @customer = current_customer
         @orders = @customer.orders.all
         
    end

    def show
        @order = Order.find(params[:id])
        @total = 0
          @order.order_details.each do |order_detail|
          @total += order_detail.price*order_detail.amount
          end
    end

    def complete
    end


  private
    def order_params
        params.require(:order).permit(:name, :postal_code, :address, :payment_method)
    end

    def cart_item_any?
       if current_customer.cart_items.empty?
          redirect_to customer_path
       end
    end
end
