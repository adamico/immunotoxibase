class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.text :description
      t.string :name, null: false
      t.references :chapter
      t.datetime :maj
      t.integer :old_id

      t.timestamps
    end
    add_index :families, :name, unique: true
    add_index :families, :chapter_id
  end
end
