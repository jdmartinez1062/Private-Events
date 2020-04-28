class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: %i[attend_event]

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = 'Sign up successfull!'
      redirect_to @user
    else
      flash.now[:warnign] = 'Sign up unsuccessfull!'
      render 'users/new'
    end
  end

  def attend_event
    @event = Event.find_by(id: params[:id])

    if current_user.attended_events << @event
      flash = 'you have joined a new event'
      redirect_to root_path
    else
      flash = 'Something went wrong'
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
    @created_events = @user.created_events.paginate(page: params[:page])
    @upcoming_events = @user.upcoming_events.paginate(page: params[:page])
    @previous_events = @user.previous_events.paginate(page: params[:page])
  end

  def update; end

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end
end
