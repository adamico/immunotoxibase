class Species < ActiveRecord::Base
  attr_accessible :name, :old_id

  has_many :assessments
  has_many :molecules, through: :assessments, dependent: :destroy

  validate :name, presence: true
end
