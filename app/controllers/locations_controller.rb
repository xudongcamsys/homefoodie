class LocationsController < ApplicationController
  before_filter :authenticate_user!

  def update
    loc = current_user.location

    # calculate moved distance
    if loc.lat and loc.loc 
      dist = nil
    end

    # only when location change is noticeable
    if dist and dist > 1 # 1 mile
      loc.update_attributes(lat: params[:lat], lng: params[:lng]) 
    end

    render nothing: true
  end

end
