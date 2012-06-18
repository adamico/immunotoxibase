class AddRowOrderToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :row_order, :integer
  end
end
