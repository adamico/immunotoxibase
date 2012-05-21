class CreateMolecules < ActiveRecord::Migration
  def change
    create_table :molecules do |t|
      t.string :name, null: false
      t.text :description
      t.string :picture_file_name, :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at
      t.references :family
      t.datetime :maj
      t.integer :old_id

      t.timestamps
    end
    add_index :molecules, :name, unique: true
    add_index :molecules, :family_id
  end
end
