class LocationsController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def update
    location = Location.find(params[:id])
    authorize location

    if location.update_attributes(location_params)
      redirect_to location.user, :notice => 'Location settings updated.'
    else
      redirect_to location.user, :alert => 'Unable to update location settings.'
    end
  end

  private

  def location_params
    params.require(:location).permit(:is_geocodable, :is_visible, :lat, :lng)
  end

end
