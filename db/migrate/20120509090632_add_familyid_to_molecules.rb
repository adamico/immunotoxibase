class AddFamilyidToMolecules < ActiveRecord::Migration
  def change
    add_column :molecules, :family_id, :integer
  end
end
