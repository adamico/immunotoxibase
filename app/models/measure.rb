class Measure < ActiveRecord::Base
  include TheSortableTree::Scopes
  attr_accessible :name, :parent_id, :old_id

  acts_as_nested_set

  has_many :assessments
  has_many :molecules, through: :assessments, dependent: :destroy, class_name: "Section"

  validate :name, presence: true

  default_scope order(:name)

  def to_s
    name
  end
end
