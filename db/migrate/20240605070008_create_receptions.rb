class CreateReceptions < ActiveRecord::Migration[5.2]
  def change
    create_table :receptions do |t|
      t.string :number
      t.references :item, foreign_key: true
      t.integer :qty
      t.text :notes
      t.boolean :is_confirm

      t.timestamps
    end
  end
end
