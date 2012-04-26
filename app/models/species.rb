class Species < ActiveRecord::Base
  attr_accessible :name

  has_many :assessments
  has_many :molecules, through: :assessments, dependent: :destroy
end
