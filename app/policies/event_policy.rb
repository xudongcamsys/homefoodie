class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    record_exists? && 
    (is_event_public? || is_participant?)
  end

  protected

  def own_record?
    user.present? && record.try(:organizer) == user
  end

  def is_participant?
    user.present? && record.participants.exists?(user.try(:id))
  end

  def is_event_public?
    !record.is_private?
  end

end
