module CreatorsHelper
  def creator_image(creator, options)
    if creator.avatar.exists?
      image_tag creator.avatar.url(options[:size]), class: options[:class]
    else
      email_hash = Digest::SHA1.hexdigest(creator.email)
      image_tag "http://www.gravatar.com/avatar/#{email_hash}?d=identicon&s=500", class: options[:class]
    end
  end

  def correct_creator?
    @creator = Creator.find(params[:id])
    return @creator == current_creator
  end
end
