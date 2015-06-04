class RaterController < ApplicationController

  def create
    if user_signed_in?
      @obj = params[:klass].classify.constantize.find(params[:id])
      @obj.rate params[:score].to_f, current_user, params[:dimension]
      @obj.create_activity :rate, owner: current_user, recipient: @obj.try(:user)
    else
      render :json => false
    end
  end
end
