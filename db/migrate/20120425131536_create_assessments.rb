class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.references :reference
      t.references :molecule
      t.references :measure
      t.references :species
      t.string :condition, :effet, :level
      t.integer :evolution
      t.integer :old_id
      t.datetime :maj

      t.timestamps
    end
    add_index :assessments, :reference_id
    add_index :assessments, :molecule_id
    add_index :assessments, :measure_id
    add_index :assessments, :species_id
  end
end
