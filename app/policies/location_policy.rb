class LocationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @location = model
  end

  def update?
    @current_user == @location.user
  end

end
