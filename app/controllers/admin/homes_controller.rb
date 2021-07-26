class Admin::HomesController < ApplicationController
  def top
    if params[:customer_id] == nil
      @orders = Order.all
    else
      @customer=Customer.find(params[:customer_id])
      @orders=@customer.orders
    end
  end
end
