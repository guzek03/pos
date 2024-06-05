class AddStateToPrices < ActiveRecord::Migration[5.2]
  def change
    add_column :prices, :state, :boolean, default: true
  end
end
