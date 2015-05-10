class DishPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @dish = model
  end

  def index?
    true
  end

  def new?
    is_current_user?
  end

  def create?
    is_current_user?
  end

  def show?
    true
  end

  def edit?
    is_current_user?
  end

  def update?
    is_current_user?
  end

  def destroy?
    is_current_user?
  end

  private

  def is_current_user?
    @current_user == @dish.user
  end

end
