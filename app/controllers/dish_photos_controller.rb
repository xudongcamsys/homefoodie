class DishPhotosController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized
  before_action :set_dish
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @dishe_photos = @dish.dish_photos.all

    authorize @dish_photos
  end

  def show
    authorize @dish_photo
  end

  def new
    @dish_photo = DishPhoto.new(dish: @dish)
    authorize @dish_photo
  end

  def edit
    authorize @dish_photo
  end

  def create
    @dish_photo = DishPhoto.new(dish_photo_params)
    authorize @dish_photo

    respond_to do |format|
      if @dish_photo.save
        format.html { redirect_to [@dish.user, @dish], notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @dish_photo }
      else
        format.html { render :new }
        format.json { render json: @dish_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @dish_photo
    respond_to do |format|
      if @dish_photo.update(dish_photo_params)
        format.html { redirect_to [@dish.user, @dish], notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @dish_photo }
      else
        format.html { render :edit }
        format.json { render json: @dish_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @dish_photo
    @dish_photo.destroy
    respond_to do |format|
      format.html { redirect_to [@dish.user, @dish], notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = Dish.find(params[:dish_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @dish_photo = DishPhoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_photo_params
      params.require(:dish_photo).permit(:title, :image).merge(dish_id: @dish.id)
    end
end
