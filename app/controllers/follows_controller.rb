class FollowsController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_user

  def create
    if @user and !current_user.follows?(@user)
      current_user.follow!(@user)

      redirect_to user_profile_path(@user)
    else
    end
  end

  def destroy
    if @user and current_user.follows?(@user)
      current_user.unfollow!(@user)

      redirect_to user_profile_path(@user)
    else
      flash[:error] = 'Unknown'
    end
  end

  private

  def get_user
    @user = User.find(params[:user_id]) if !params[:user_id].blank?
  end
end