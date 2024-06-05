class AddStartDateAndEndDateToPrices < ActiveRecord::Migration[5.2]
  def change
    add_column :prices, :start_date, :date
    add_column :prices, :end_date, :date
  end
end
