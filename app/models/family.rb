class Family < ActiveRecord::Base
  attr_accessible :description, :name, :chapter_id

  belongs_to :chapter
  has_many :molecules

  def to_s
    name
  end

  def parent
    chapter
  end

  def children
    molecules
  end

  def child_class_name
    "molecule"
  end
end
