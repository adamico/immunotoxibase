class Reference < ActiveRecord::Base
  attr_accessible :description, :name, :source, :url, :old_id

  has_many :assessments

  validate :name, presence: true
end
