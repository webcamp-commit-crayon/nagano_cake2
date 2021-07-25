class Admin::OrderDetailsController < ApplicationController

  def update
   @order_detail=OrderDetail.find(params[:id])
   @order=@order_detail.order
   @order_detail.update(order_detail_params)
   if @order_detail.making_status == "制作中"
     @order.update(status: "制作中")
   end
   order_details=OrderDetail.where(order_id: @order_detail.order_id)
   complete_item=order_details.where(making_status: "制作完了")
   if  complete_item.count == order_details.count
     @order.update(status: "発送準備中")
   end
   redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end

