class CreatorsController < ApplicationController
  before_action :correct_creator,   only: [:edit, :update, :destroy]

  def index
    if params[:tag]
      @creators = Creator.tagged_with(params[:tag])
    else
      @creators = Creator.all.order("RANDOM()")
    end
  end

  def show
    @creator = Creator.find(params[:id])
    @creator.accounts ||= {}

    respond_to do |format|
      format.html {}
      format.js {}
    end
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
      redirect_to root_path
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
      params.require(:creator).permit(:name, :email, :password, :password_confirmation, :city, :description, :tag_list, :avatar, :accounts)
    end

    def correct_creator
      @creator = Creator.find(params[:id])
      flash[:alert] = "Sorry, you aren't allowed to edit that." unless @creator == current_creator
      redirect_to root_url unless @creator == current_creator
    end

end
