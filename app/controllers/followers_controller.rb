class FollowersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @followers = @user.followers(User)
  end
end