class AuctionProductPolicy < BasePolicy
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
          scope.where(creator_id: context[:user].id)
        else
          scope.all
        end
      end
    end
  end