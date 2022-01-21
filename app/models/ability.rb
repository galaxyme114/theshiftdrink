class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :update, :destroy, :to => :administrate

    can :read, :all unless user.role == 'Reader'

    if user.role == 'Administrator'
      can :manage, :all
    end
    
    if user.role != 'Reader'
      can    :update,  User, id: user.id
      cannot :destroy, User, id: user.id
    end
  end
end
