class Chapter < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :families

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
