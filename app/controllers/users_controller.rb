class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, except: [:index]
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    authorize @user
  end

  def update
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to @user, :notice => "User updated."
    else
      redirect_to @user, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    authorize @user 

    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update_attributes(secure_params)
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end

    redirect_to root_url
  end

  private

  def secure_params
    params.require(:user).permit(:name, :role, :avatar)
  end

   def set_user
    @user = User.find(params[:id])
  end

end
