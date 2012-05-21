class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.string :name, null: false
      t.integer :old_id

      t.timestamps
    end
    add_index :species, :name, unique: true
  end
end
