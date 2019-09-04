class StrikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user_is_admin?
  end

  def search?
    true
  end

  def create?
    user_is_admin?
  end

  def show?
    true
  end

  def edit?
    user_is_admin?
  end

  def update?
    user_is_admin?
  end

  def destroy?
    user_is_admin?
  end

  private

  def user_is_admin?
    user.admin
  end
end
