class CreatorsController < ApplicationController
  def index
    if params[:tag]
      @creators = Creator.tagged_with(params[:tag])
    else
      @creators = Creator.all
    end
  end

  def show
    @creator = Creator.find(params[:id])
  end

  def new
    @creator = Creator.new
  end

  def edit
    @creator = Creator.find(params[:id])
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
    @creator = Creator.find(params[:id])
    if @creator.update_attributes(creator_params)
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
      params.require(:creator).permit(:name, :email, :password, :password_confirmation, :tag_list)
    end

end
