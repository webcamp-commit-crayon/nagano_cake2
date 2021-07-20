class AddIsValidToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :is_valid, :boolean, default: true, null: false
  end
end
