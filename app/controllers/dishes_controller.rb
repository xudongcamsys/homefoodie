class DishesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized
  before_action :set_user
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  def index
    if params[:tag]
      @dishes = @user.dishes.tagged_with(params[:tag])
    else
      @dishes = @user.dishes.all
    end

    authorize @dishes
  end

  def new
    @dish = Dish.new(user: @user)
    authorize @dish
  end

  def create
    @dish = Dish.new(dish_params)
    authorize @dish

    respond_to do |format|
      if @dish.save
        format.html { redirect_to [@user, @dish], notice: 'Dish was successfully created.' }
        format.json { render :show, status: :created, location: @dish }
      else
        format.html { render :new }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @dish.update(dish_params)
        format.html { redirect_to [@user, @dish], notice: 'Dish was successfully updated.' }
        format.json { render :show, status: :ok, location: @dish }
      else
        format.html { render :edit }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dish.destroy
    respond_to do |format|
      format.html { redirect_to user_dishes_url(@user), notice: 'Dish was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = Dish.find(params[:id])
      authorize @dish
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_params
      params.require(:dish).permit(:name, :food_preference_id, :food_type_id, :cuisine_id, :ingredients, :tag_list).merge(user_id: @user.id)
    end
end
