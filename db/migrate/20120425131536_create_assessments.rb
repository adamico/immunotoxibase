class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :reference_id
      t.integer :molecule_id
      t.integer :measure_id
      t.integer :species_id
      t.string :condition
      t.string :effet
      t.integer :evolution
      t.string :level

      t.timestamps
    end
  end
end
