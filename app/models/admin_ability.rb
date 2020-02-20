class AdminAbility
  include CanCan::Ability
  def initialize(user)
    if user.kind_of? Admin
      can :manage, :all
      
      # Can't edit or delete tracking links that have converted
      cannot [:edit, :destroy], TrackingLink, converted: true
      
      # Now setup what a mod CAN'T do:
      # Money, promo codes
      if user.role == ROLE_MODERATOR
        cannot :manage, Email
        cannot :manage, TrackingLink
        cannot :manage, Subscription
        cannot :manage, PromoCode
        cannot :manage, StaticPage
        cannot :manage, SiteSetting
        cannot :manage, MasseurDocumentation
      end
    end
  end
end