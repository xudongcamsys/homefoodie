class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.includes(:profile).all.order(:id)
    authorize Profile
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
    authorize @profile

    @activities = PublicActivity::Activity.where(owner: @user)
  end
end
