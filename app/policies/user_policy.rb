class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    is_admin?
  end

  def show?
    is_admin? or is_current_user?
  end

  def update?
    is_admin?
  end

  def finish_signup?
    is_current_user?
  end

  def destroy?
    return false if is_current_user?
    is_admin?
  end

  private

  def is_admin?
    @current_user.admin?
  end

  def is_current_user?
    @current_user == @user
  end

end
