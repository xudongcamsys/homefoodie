class LocationsController < ApplicationController
  before_filter :authenticate_user!

  def update
    loc = current_user.location

    loc.update_latlng params[:lat], params[:lng] if loc

    render nothing: true
  end

end
