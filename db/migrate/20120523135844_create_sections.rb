class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name, null: false
      t.text :description
      t.string :picture_file_name, :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :parent_id
      t.datetime :maj
      t.string :old_id

      t.timestamps
    end
    add_index :sections, :name, unique: true
    add_index :sections, :parent_id
  end
end
