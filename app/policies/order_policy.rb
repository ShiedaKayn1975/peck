class OrderPolicy < BasePolicy
    def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  class Scope < Scope
    def resolve
      if context[:user].current_app == 'seller'
        scope.where(owner_id: context[:user].id)
      else
        scope.where(customer_id: context[:user].id)
      end
    end
  end
end