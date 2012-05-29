class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user
      default_rules_for(user)
      admin_rules_for(user) if user.admin?
    end
  end

  def admin_rules_for(user)
    can :manage, :all
    can :rebuild, Measure
    can :tree, Measure
  end

  def default_rules_for(user)
    can :read, :all
    can :toc, Section
  end
  #
  # The first argument to `can` is the action you are giving the user permission to do.
  # If you pass :manage it will apply to every action. Other common actions here are
  # :read, :create, :update and :destroy.
  #
  # The second argument is the resource the user can perform the action on. If you pass
  # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
  #
  # The third argument is an optional hash of conditions to further filter the objects.
  # For example, here the user can only update published articles.
  #
  #   can :update, Article, :published => true
  #
  # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
end
