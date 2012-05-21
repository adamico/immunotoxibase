class Assessment < ActiveRecord::Base
  attr_accessible :reference_id, :molecule_id, :measure_id, :species_id, :condition, :effet, :level, :evolution, :old_id, :maj

  belongs_to :reference
  belongs_to :molecule
  belongs_to :measure
  belongs_to :species
end
