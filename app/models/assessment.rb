class Assessment < ActiveRecord::Base
  attr_accessible :reference_id, :molecule_id, :measure_id, :species_id, :condition, :effet, :level, :evolution, :old_id, :maj, :row_order, :reference_description

  belongs_to :reference
  belongs_to :molecule, class_name: "Section"
  belongs_to :measure
  belongs_to :species

  include RankedModel
  ranks :row_order,
    with_same: :molecule_id

  EVOLUTION = [["<i class='icon-arrow-down'></i>".html_safe, -1],["<i class='icon-resize-horizontal'></i>".html_safe, 0], ["<i class='icon-arrow-up'></i>".html_safe, 1]]

  def reference_description
    reference.description if reference
  end
  def reference_description=(description)
    self.reference = Reference.find_by_description(description) unless description.blank?
  end
end
