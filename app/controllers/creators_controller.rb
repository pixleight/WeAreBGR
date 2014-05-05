class CreatorsController < ApplicationController
  def new
    @creator = Creator.new
  end

  def create
    @creator = Creator.new(creator_params)
    if @creator.save
      flash[:success] = "Welcome to WeAreBGR!"
      redirect_to @creator
    else
      render 'new'
    end
  end

  def show
    @creator = Creator.find(params[:id])
  end

  private

    def creator_params
      params.require(:creator).permit(:name, :email, :password, :password_confirmation)
    end

end
