class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :code
      t.string :name
      t.boolean :state, default: true

      t.timestamps
    end
  end
end
