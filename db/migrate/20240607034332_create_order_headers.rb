class CreateOrderHeaders < ActiveRecord::Migration[5.2]
  def change
    create_table :order_headers do |t|
      t.string :number
      t.string :customer_name
      t.string :invoice_number
      t.date :invoice_date
      t.integer :state, default: 0

      t.timestamps
    end
  end
end
