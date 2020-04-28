class EventsController < ApplicationController
  include SessionsHelper
  def index
    @upcoming_events = Event.upcoming.paginate(page: params[:page])
    @previous_events = Event.past.paginate(page: params[:page])
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find_by(id: params[:id])
    @users = @event.attendees.paginate(page: params[:page])
  end

  def edit; end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = 'Event created!'
      redirect_to root_url
    else
      flash[:warning] = 'Event not created!'
      redirect_to root_url
    end
  end

  def update; end

  def destroy; end

  private

  def event_params
    params.require(:event).permit(:location, :date)
  end
end
