class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.string :name, null: false
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :parent_id
      t.integer :old_id

      t.timestamps
    end
    add_index :measures, :name, unique: true
    add_index :measures, :parent_id
  end
end
