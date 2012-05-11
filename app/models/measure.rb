class Measure < ActiveRecord::Base
  include TheSortableTree::Scopes
  attr_accessible :depth, :lft, :name, :parent_id, :rgt

  acts_as_nested_set

  has_many :assessments
  has_many :molecules, through: :assessments, dependent: :destroy

  def to_s
    name
  end
end
