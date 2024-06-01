class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.references :item, foreign_key: true
      t.decimal :price, precision: 15, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
