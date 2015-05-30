class UserPolicy< ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    can_admin?
  end

  def show?
    owner? || can_admin?
  end

  def update?
    owner? || can_admin?
  end

end
