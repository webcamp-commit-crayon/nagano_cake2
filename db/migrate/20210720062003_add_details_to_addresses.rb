class AddDetailsToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :postal_code, :string
    add_column :addresses, :address, :string
    add_column :addresses, :name, :string
  end
end
