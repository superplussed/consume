class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :manage, :all
      cannot :scrape, :all 
      can :scrape, [JobListing]
    end
  end
end