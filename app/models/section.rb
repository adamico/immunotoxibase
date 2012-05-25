class Section < ActiveRecord::Base
  include TheSortableTree::Scopes
  attr_accessible :name, :description, :picture, :maj, :parent_id, :old_id, :assessments_attributes

  acts_as_nested_set

  has_attached_file :picture, fog_credentials: {
                      aws_access_key_id: ENV['S3_KEY'],
                      aws_secret_access_key: ENV['S3_SECRET'],
                      provider: 'AWS'
                    }

  validates :name, presence: true

  has_many :assessments, foreign_key: "molecule_id"
  has_many :measures, through: :assessments, dependent: :destroy
  has_many :species, through: :assessments, dependent: :destroy

  accepts_nested_attributes_for :assessments, :reject_if => :all_blank, allow_destroy: true

  include PgSearch
  pg_search_scope :search, against: [:name, :description],
    using: {tsearch: {dictionary: "english"}}

  def to_s
    name
  end

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
