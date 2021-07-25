class Public::AddressesController < ApplicationController

    def index
        @address   = Address.new
        @customer = current_customer
        @addresses = @customer.addresses.all
    end

    def create
        @address             = Address.new(address_params)
        @addresses           = Address.all
        @address.customer_id = current_customer.id
        if @address.save
          redirect_to addresses_path
          flash[:info]       = '登録に成功しました。'
        else
          render "index"
          flash.now[:danger] = '登録に失敗しました。'
        end
    end

    def edit
        @address = Address.find(params[:id])
    end

    def update
        @address             = Address.find(params[:id])
        @address.customer_id = current_customer.id
        if @address.update(address_params)
          redirect_to addresses_path, notice: "You have updated user successfully."
        else
           render "edit"
        end
    end

    def destroy
        address = Address.find(params[:id])
        address.destroy
        redirect_to addresses_path
    end

    private

    def address_params
    params.require(:address).permit(:postal_code, :address, :name)
    end

end
