class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized
  before_action :set_user
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    if params[:type] == 'past'
      @events = @user.past_events
    elsif params[:type] == 'upcoming'
      @events = @user.upcoming_events
    else
      @events = @user.today_events
    end
    
    is_public_only = current_user != @user
    @events = @events.public_only if is_public_only

    authorize @events
  end

  def new
    @event = Event.new(organizer: @user)
    @event.event_address = EventAddress.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.scheduled_at = parse_scheduled_at
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

  def edit
  end

  def update
    respond_to do |format|
      if @event.update(event_params.clone.merge(scheduled_at: parse_scheduled_at))
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
      params.require(:event).permit(:organizer_id, :name, :description, :capacity, :scheduled_at, :scheduled_hours, :is_private,
        { event_address_attributes:
          [ :lat, :lng, :address, :id ] })
    end

    # datetime param causes trouble when create&update an event
    def parse_scheduled_at
      Chronic.parse(event_params[:scheduled_at])
    end
end
