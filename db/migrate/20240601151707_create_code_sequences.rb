class CreateCodeSequences < ActiveRecord::Migration[5.2]
  def change
    create_table :code_sequences do |t|
      t.string :code
      t.integer :year
      t.integer :sequence

      t.timestamps
    end
  end
end
