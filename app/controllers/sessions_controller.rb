class SessionsController < ApplicationController
  def new
  end

  def create
    creator = Creator.find_by(email: params[:session][:email].downcase)
    if creator && creator.authenticate(params[:session][:password])
      # Sign in
      sign_in creator
      flash[:success] = "Welcome back, #{creator.name}!"
      redirect_to root_path
    else
      # Create an error message & re-render the signin form
      flash.now[:alert] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = "Successfully signed out."
    redirect_to root_url
  end
end
