class SessionsController < ApplicationController
  include SessionsHelper
  def new
   
  end

  def create
    user = User.find_by(name: params[:session][:name])
    return unless user
      log_in(user)
      redirect_to user
  end

  def destroy
  end
end
