class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:info]        = '登録に成功しました。'
       redirect_to admin_item_path(@item)
    else
       flash.now[:danger] = '登録に失敗しました。'
       render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
  @item =Item.find(params[:id])
  if @item.update(item_params)
    flash[:info]       = '登録に成功しました。'
    redirect_to admin_item_path(@item)
  else
    flash.now[:danger] = '登録に失敗しました。'
    render "edit"
  end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
