class LocationsController < ApplicationController
  before_filter :authenticate_user!

  def update
    loc = current_user.location
    loc.update_attributes(lat: params[:lat], lng: params[:lng]) 

    render nothing: true
  end

end
