class FolloweesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @followees = @user.followees(User)
    @activities = PublicActivity::Activity.where(owner: @followees)
  end

end