class ReminderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def destroy?
    check_if_owner?
  end

  private

  def check_if_owner?
    record.user == user
  end
end
