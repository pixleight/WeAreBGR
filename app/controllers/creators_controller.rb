class CreatorsController < ApplicationController
  def index
    @creators = Creator.all
  end

  def show
    @creator = Creator.find(params[:id])
  end

  def new
    @creator = Creator.new
  end

  def edit
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

  def update
    if @creator.update
      flash[:success] = "Profile successfully updated"
      redirect_to @creator
    else
      render action: 'edit'
    end
  end

  def destroy
    if @creator.destroy
      redirect_to creators_url
    end
  end

  private

    def creator_params
      params.require(:creator).permit(:name, :email, :password, :password_confirmation)
    end

end
