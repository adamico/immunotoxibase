class Molecule < ActiveRecord::Base
  attr_accessible :description, :name
  def to_s
    name.capitalize
  end

  include PgSearch
  pg_search_scope :search, against: [:name, :description],
    using: {tsearch: {dictionary: "english"}}

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
