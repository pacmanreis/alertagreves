class SubmittedStrikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_is_admin?
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    user_is_admin?
  end

  private

  def user_is_admin?
    user.admin
  end
end
