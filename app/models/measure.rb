class Measure < ActiveRecord::Base
  include TheSortableTree::Scopes
  attr_accessible :name, :lft, :rgt, :depth, :parent_id, :old_id

  acts_as_nested_set

  has_many :assessments
  has_many :molecules, through: :assessments, dependent: :destroy

  validate :name, presence: true

  def to_s
    name
  end
end
