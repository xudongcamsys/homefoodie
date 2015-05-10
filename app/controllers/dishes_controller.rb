class DishesController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized
  before_action :set_user
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  # GET /dishes
  # GET /dishes.json
  def index
    @dishes = @user.dishes.all
    authorize @dishes
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
    authorize @dish
  end

  # GET /dishes/new
  def new
    @dish = Dish.new(user: @user)
    authorize @dish
  end

  # GET /dishes/1/edit
  def edit
    authorize @dish
  end

  # POST /dishes
  # POST /dishes.json
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

  # PATCH/PUT /dishes/1
  # PATCH/PUT /dishes/1.json
  def update
    authorize @dish
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

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    authorize @dish
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_params
      params.require(:dish).permit(:name, :food_preference_id, :food_type_id, :cuisine_id, :ingredients).merge(user_id: @user.id)
    end
end
