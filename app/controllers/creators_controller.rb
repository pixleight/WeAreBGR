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

    # Create 8 character hash of email, generate Identicon & save with that filename
    email_hash = Digest::SHA1.hexdigest(@creator.email)[0,8]
    RubyIdenticon.create_and_save(@creator.email, "public/images/creators/identicons/#{email_hash}.png",
      border_size: 0,
      grid_size: 9,
      square_size: 60
    )

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
      params.require(:creator).permit(:name, :email, :password, :password_confirmation, :city, :tag_list, :avatar, :accounts)
    end

    def correct_creator
      @creator = Creator.find(params[:id])
      flash[:alert] = "Sorry, you aren't allowed to edit that." unless @creator == current_creator
      redirect_to root_url unless @creator == current_creator
    end

end
