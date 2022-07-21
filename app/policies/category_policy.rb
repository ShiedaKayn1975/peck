class CategoryPolicy < BasePolicy
    def index?
    true
  end

  def create?
    false
  end

  def show?
    true
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end