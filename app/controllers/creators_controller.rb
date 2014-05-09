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
    @creator.accounts ||= {}
  end

  def ajax
    @creator = Creator.find(params[:id])
    @creator.accounts ||= {}
    render partial: 'show'  # Show only the partial of the page
  end

  def new
    @creator = Creator.new
    @creator.accounts = {}
  end

  def edit
    @creator = Creator.find(params[:id])
    @creator.accounts ||= {}
  end

  def create
    @creator = Creator.new(creator_params)
    @creator.accounts = params[:creator][:accounts]

    if @creator.save
      flash[:success] = "Welcome to WeAreBGR!"
      redirect_to @creator
    else
      render 'new'
    end
  end

  def update
    @creator = Creator.find(params[:id])
    @creator.accounts = params[:creator][:accounts]
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
      params.require(:creator).permit(:name, :email, :password, :password_confirmation, :tag_list, :avatar, :accounts)
    end

end
