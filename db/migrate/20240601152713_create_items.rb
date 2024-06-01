class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :sku
      t.string :name
      t.boolean :state
      t.references :uom, foreign_key: true

      t.timestamps
    end
  end
end
