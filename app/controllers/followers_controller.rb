class FollowersController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_user

  def index
    @users = @user.followers(User)
  end

  private

  def get_user
    @user = User.find(params[:user_id]) if !params[:user_id].blank?
  end
end