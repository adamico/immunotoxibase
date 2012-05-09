class Chapter < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :families
end
