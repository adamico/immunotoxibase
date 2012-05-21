require 'active_support/concern'

module Concerns::Models::Prolific
  extend ActiveSupport::Concern

  def has_children?
    self.respond_to?(:children) && self.children.any?
  end
end
