class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :manage, :all
      cannot :edit, :all
      cannot :show, :all
      cannot :history, :all
      cannot :show_in_app, :all
      can :scrape, [JobListing]
    end
  end
end