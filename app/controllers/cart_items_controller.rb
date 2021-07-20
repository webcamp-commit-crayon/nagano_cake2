class CartItemsController < ApplicationController
  def index
    @cart_items = current_member.cart_items
    @total      = 0
  end

  def create
    if current_member.cart_items.count >= 1
      if nil != current_member.cart_items.find_by(item_id: params[:cart_item][:item_id])
        @cart_item_u                  = current_member.cart_items.find_by(item_id: params[:cart_item][:item_id])
        @cart_item_u.number_of_items += params[:cart_item][:number_of_items].to_i
        @cart_item_u.update(number_of_items: @cart_item_u.number_of_items)
        redirect_to public_cart_items_path
      else
        @cart_item           = CartItem.new(cart_item_params)
        @cart_item.member_id = current_member.id
        if @cart_item.save
          redirect_to public_cart_items_path
        else
          @items    = Item.where(sale_status: 0).page(params[:page]).per(8)
          @quantity = Item.count
          @genres   = Genre.where(valid_invalid_status: 0)
          render 'index'
        end
      end

    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.member_id = current_member.id
      if @cart_item.save
        redirect_to public_cart_items_path
      else
        @items = Item.where(sale_status: 0).page(params[page]).par(8)
        @quantity = Item.count
        @genres   = Genre.where(valid_invalid_status: 0)
        render 'index'
      end
    end
  end

  def update
    @cart_item = CartItem.find_by(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find_by(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    @cart_items = carrent_member.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private
  def cart_item_item?
    redirect_to public_item_path(params[:cart_item][:item_id]), notice: "個数を入力してください。" if params[:cart_item][:number_of_items].empty?
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :number_of_items, :member_id)
  end
end
