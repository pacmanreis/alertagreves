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

  def approval?
    user_is_admin?
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

  def calendar?
    true
  end

  def mobile_filter?
    true
  end

  def about_us?
    true
  end

  private

  def user_is_admin?
    user.admin
  end
end
