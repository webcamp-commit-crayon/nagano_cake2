class Admin::OrdersController < ApplicationController
  def show
    @order               = Order.find(params[:id])
    @order.shipping_cost = 800
    @total               = 0
    @order.order_details.each do |detail|
      @total += detail.price*detail.amount*1.1
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "入金確認"
       @order_details = @order.order_details
       @order_details.update(making_status: "制作待ち")
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
