class DishPhotoLikesController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_dish_photo

  def create
    if @dish_photo and !current_user.likes?(@dish_photo)
      current_user.like!(@dish_photo)
      @dish_photo.create_activity :like, owner: current_user, recipient: @dish_photo.dish.user
    end
  end

  private

  def get_dish_photo
    @dish_photo = DishPhoto.find(params[:dish_photo_id])
  end
end