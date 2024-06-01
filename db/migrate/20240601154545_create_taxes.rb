class CreateTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :taxes do |t|
      t.decimal :percentage
      t.integer :year
      t.boolean :state, default: true

      t.timestamps
    end
  end
end
