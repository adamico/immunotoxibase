class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.text :description
      t.string :name, null: false
      t.integer :old_id

      t.timestamps
    end
    add_index :chapters, :name, unique: true
  end
end
