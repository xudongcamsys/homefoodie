class FolloweesController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_user

  def index
    @followees = @user.followees(User)
    @activities = PublicActivity::Activity.where(owner: @followees)
  end

  private

  def get_user
    @user = User.find(params[:user_id]) if !params[:user_id].blank?
  end
end