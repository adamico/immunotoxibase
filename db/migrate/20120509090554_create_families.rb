class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
