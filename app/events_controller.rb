class DishesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized
  before_action :set_user
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = @user.organized_events

    authorize @events
  end

  def new
    @event = Event.new(organizer: @user)
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    authorize @event

    respond_to do |format|
      if @event.save
        format.html { redirect_to [@user, @event], notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to [@user, @event], notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to user_events_url(@user), notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
      authorize @event
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :max_participant_count, :scheduled_at, :scheduled_hours, 
        { event_address_attributes:
          [ :lat, :lng, :address, :id ] }).merge(organizer_id: @user.id)
    end
end