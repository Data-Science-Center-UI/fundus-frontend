# frozen_string_literal: true

# Ability class to define current_user permissions
class Ability
  include CanCan::Ability

  def initialize(current_user)
    # Define abilities for the current_user here. For example:
    #
    #   return unless current_user.present?
    #   can :read, :all
    #   return unless current_user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the current_user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the current_user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the current_user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    # Admin only can manage (R/W) User
    can :manage, User if current_user&.admin?

    # Doctor only can Read/Create Detection, and Read DetectionReport
    can %i[read create], Detection if current_user&.doctor?
    can [:read], DetectionReport if current_user&.doctor?
  end
end
