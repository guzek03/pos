class RenameColumnCurrentQuantitiFromStocks < ActiveRecord::Migration[5.2]
  def change
    rename_column :stocks, :current_quantity, :current_qty
  end
end
