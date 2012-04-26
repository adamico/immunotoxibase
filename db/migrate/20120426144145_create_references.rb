class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :name
      t.text :description
      t.string :source
      t.string :url

      t.timestamps
    end
  end
end
