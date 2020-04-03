class UsersController < ApplicationController
  include SessionsHelper
  def new
    @user = User.new()
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = 'Sign up successfull'
      redirect to @user
    else
      flash.now[:warnign] = 'Sign up unsuccessfull'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update; end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
