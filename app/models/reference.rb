class Reference < ActiveRecord::Base
  attr_accessible :description, :name, :source, :url

  has_many :assessments
end
