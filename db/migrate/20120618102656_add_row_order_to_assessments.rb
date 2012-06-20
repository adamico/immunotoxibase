class AddRowOrderToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :position, :integer
  end
end
