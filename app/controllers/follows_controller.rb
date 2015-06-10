class FollowsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @followee = User.find(params[:user_id])
    if !current_user.follows?(@followee)
      current_user.follow!(@followee)
      current_user.create_activity :follow, owner: current_user, recipient: @followee
    end

    redirect_to :back
  end

  def destroy
    @followee = User.find(params[:user_id])
    if current_user.follows?(@followee)
      current_user.unfollow!(@followee)
    end

    redirect_to :back
  end
end