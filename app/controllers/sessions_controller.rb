class SessionsController < ApplicationController
  def new
  end

  def create
    creator = Creator.find_by(email: params[:session][:email].downcase)
    if creator && creator.authenticate(params[:session][:password])
      # Sign in
      sign_in creator
      redirect_to creator
    else
      # Create an error message & re-render the signin form
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
