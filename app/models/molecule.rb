class Molecule < ActiveRecord::Base
  attr_accessible :description, :name, :assessments_attributes, :family_id

  belongs_to :family
  has_many :assessments
  has_many :measures, through: :assessments, dependent: :destroy
  has_many :species, through: :assessments, dependent: :destroy

  accepts_nested_attributes_for :assessments, :reject_if => :all_blank, allow_destroy: true

  include PgSearch
  pg_search_scope :search, against: [:name, :description],
    using: {tsearch: {dictionary: "english"}}

  def parent
    family
  end

  def to_s
    name.capitalize
  end

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
