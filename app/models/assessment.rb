class Assessment < ActiveRecord::Base
  attr_accessible :reference_id, :molecule_id, :measure_id, :species_id, :condition, :effet, :level, :evolution, :old_id, :maj, :row_order

  belongs_to :reference
  belongs_to :molecule, class_name: "Section"
  belongs_to :measure
  belongs_to :species

  delegate :name, to: :measure, prefix: true, allow_nil: true
  delegate :name, to: :species, prefix: true, allow_nil: true

  include RankedModel
  ranks :row_order,
    with_same: :molecule_id
end
