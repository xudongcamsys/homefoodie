class FollowersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @followers = @user.followers(User)
  end
end