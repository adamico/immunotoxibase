class Family < ActiveRecord::Base
  attr_accessible :description, :name, :chapter_id

  belongs_to :chapter
  has_many :molecules
end
