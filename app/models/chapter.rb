class Chapter < ActiveRecord::Base
  include Concerns::Models::Prolific
  attr_accessible :description, :name, :old_id

  has_many :families

  validates :name, presence: true

  def to_s
    name
  end

  def children
    families
  end

  def child_class_name
    "family"
  end
end
