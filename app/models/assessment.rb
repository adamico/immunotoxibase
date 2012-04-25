class Assessment < ActiveRecord::Base
  attr_accessible :condition, :effet, :evolution, :level, :measure_id, :molecule_id, :reference_id, :species_id

  belongs_to :molecule
end
