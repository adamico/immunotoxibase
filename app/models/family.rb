class Family < ActiveRecord::Base
  include Concerns::Models::Prolific
  attr_accessible :description, :name, :chapter_id, :maj, :old_id

  belongs_to :chapter
  has_many :molecules

  validate :name, presence: true

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
