class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  protected

  def own_record?
    user.present? && record.try(:organizer) == user
  end

end
