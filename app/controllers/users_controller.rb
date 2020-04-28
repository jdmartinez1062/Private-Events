class UsersController < ApplicationController
  include SessionsHelper
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
end
