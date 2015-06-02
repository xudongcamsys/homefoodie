class DishPhotoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  private

  def own_record?
    user.present? && @record.dish.owner?(user)
  end

end
