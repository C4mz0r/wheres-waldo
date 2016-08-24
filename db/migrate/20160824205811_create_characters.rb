class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :xPosition
      t.integer :yPosition
      t.boolean :isFound
      t.references :picture, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
