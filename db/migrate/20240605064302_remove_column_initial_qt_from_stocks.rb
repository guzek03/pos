class RemoveColumnInitialQtFromStocks < ActiveRecord::Migration[5.2]
  def change
    remove_column :stocks, :initial_qty
  end
end
