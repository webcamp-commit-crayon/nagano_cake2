class AddColumnsToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :last_name, :string
    add_column :customers, :first_name, :string
    add_column :customers, :postal_code, :string
    add_column :customers, :address, :string
    add_column :customers, :phone_number, :string
    add_column :customers, :is_deleted, :boolean
  end
end
