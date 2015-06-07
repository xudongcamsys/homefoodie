class FollowsController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_user

  def create
    if @user and !current_user.follows?(@user)
      current_user.follow!(@user)
      current_user.create_activity :follow, owner: current_user, recipient: @user

      redirect_to :back
    else
    end
  end

  def destroy
    if @user and current_user.follows?(@user)
      current_user.unfollow!(@user)

      redirect_to :back
    else
      flash[:error] = 'Unknown'
    end
  end

  private

  def get_user
    @user = User.find(params[:user_id]) if !params[:user_id].blank?
  end
end