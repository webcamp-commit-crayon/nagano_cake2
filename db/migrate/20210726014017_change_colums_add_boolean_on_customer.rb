class ChangeColumsAddBooleanOnCustomer < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :is_deleted, :boolean, default: false, null: false
  end
end
