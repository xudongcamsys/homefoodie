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
    own_record? || can_admin?
  end

end
