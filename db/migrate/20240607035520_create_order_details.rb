class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.references :order_header, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :qty_request, default: 0
      t.integer :qty_available, default: 0
      t.decimal :price_include, precision: 15, scale: 2, null: false, default: 0.0
      t.decimal :price_exclude, precision: 15, scale: 2, null: false, default: 0.0
      t.decimal :percentage_ppn, precision: 15, scale: 2, null: false, default: 0.0
      t.boolean :is_confirm

      t.timestamps
    end
  end
end
