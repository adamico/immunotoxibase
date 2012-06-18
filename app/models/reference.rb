class Reference < ActiveRecord::Base
  attr_accessible :description, :name, :source, :url, :old_id

  has_many :assessments

  validate :name, presence: true

  def oldid_or_id
    old_id ? old_id : id
  end

  def to_s
    oldid_or_id
  end
end
