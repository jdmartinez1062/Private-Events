class StaticPagesController < ApplicationController
  include SessionsHelper
  def home
    @event = current_user.created_events.build if logged_in?
    @events = Event.paginate(page: params[:page])
  end

  def help; end
end
