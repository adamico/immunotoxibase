class Section < ActiveRecord::Base
  include TheSortableTree::Scopes
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name, :description, :picture, :maj, :parent_id, :old_id, :assessments_attributes, :slug, :delete_picture

  acts_as_nested_set

  has_attached_file :picture,
                      storage: :s3,
                      bucket: ENV['S3_BUCKET'],
                      s3_credentials: {
                        access_key_id: ENV['S3_KEY'],
                        secret_access_key: ENV['S3_SECRET']
                      }

  validates :name, presence: true

  before_validation :clear_picture

  has_many :assessments, foreign_key: "molecule_id", order: "position"
  has_many :measures, through: :assessments, dependent: :destroy
  has_many :species, through: :assessments, dependent: :destroy

  accepts_nested_attributes_for :assessments, :reject_if => :all_blank, allow_destroy: true

  include PgSearch
  pg_search_scope :search, against: [:name, :description],
    using: {tsearch: {dictionary: "english"}}

  DEPTH = {0 => "chapter", 1 => "family", 2 => "molecule"}

  def depth_name
    depth ? DEPTH[depth] : parent.child_name
  end

  def child_name
    molecule? ? nil : DEPTH[depth + 1]
  end

  def molecule?
    if parent
      depth ? depth == 2 : parent.depth == 1
    else
      false
    end
  end

  def to_s
    name
  end

  def clear_picture
    self.picture = nil if delete_picture? && !picture.dirty?
  end

  def delete_picture=(value)
    @delete_picture = !value.to_i.zero?
  end

  def delete_picture
    !!@delete_picture
  end

  alias_method :delete_picture?, :delete_picture
end
