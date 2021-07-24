class Order < ApplicationRecord
   has_many :order_details, dependent: :destroy
    
   belongs_to :customer
   
   enum payment_method: {クレジットカード:1, 銀行振込:2}
end
