class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :name, null: false
      t.text :description
      t.string :source
      t.string :url
      t.integer :old_id

      t.timestamps
    end
    add_index :references, :name, unique: true
  end
end
