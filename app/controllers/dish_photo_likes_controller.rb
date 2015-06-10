class DishPhotoLikesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @dish_photo = DishPhoto.find(params[:dish_photo_id])
    if !current_user.likes?(@dish_photo)
      current_user.like!(@dish_photo)
      @dish_photo.create_activity :like, owner: current_user, recipient: @dish_photo.dish.user
    end
  end
end