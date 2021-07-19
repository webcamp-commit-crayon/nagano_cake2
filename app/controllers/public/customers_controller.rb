class Public::CustomersController < ApplicationController
    
    def show
        @customer = Customer.find(params[:id])
    end

    def edit
    end
    
    def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated user successfully."
    else
      render "edit"
    end
    end
    
    def unsubscrib
    end
    
    private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number)
  end
   
end
