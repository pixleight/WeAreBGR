class CreatorsController < ApplicationController
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
    email_hash = self.short_email_hash(@creator.email)
    #identicon = Identiconify::Identicon.new(email_hash)
    #identicon_data = identicon.to_png_blob

    #File.open("public/images/creators/identicons/#{email_hash}.png", "w") do |file|
    #  file.write(identicon_data)
    #end

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

  def short_email_hash(email)
    email_hash = Digest::SHA1.hexdigest @creator.email
    return email_hash[0,8]
  end

  private

    def creator_params
      params.require(:creator).permit(:name, :email, :password, :password_confirmation, :tag_list, :avatar, :accounts)
    end

end
