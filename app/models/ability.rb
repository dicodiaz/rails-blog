class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :read, Comment
    return unless user.present?

    can :manage, Post, author: user
    can :manage, Comment, author: user
    return unless user.admin?

    can :manage, Post
    can :manage, Comment
  end
end
