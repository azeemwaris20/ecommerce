# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    return unless user.present?

    can :update, Product, user_id: user.id
    can :destroy, Product, user_id: user.id
    can :destroy, Comment, user_id: user.id
    can :update, Comment, user_id: user.id
    can :create, Product
    can :create, Comment do |comment|
      !user.products.include?(comment.try(:product))
    end
  end
end
