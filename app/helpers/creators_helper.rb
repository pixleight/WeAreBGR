module CreatorsHelper
  def creator_image(creator, options)
    if creator.avatar.exists?
      image_tag creator.avatar.url(options[:size])
    else
      email_hash = Digest::SHA1.hexdigest(creator.email)[0,8]
      image_tag "creators/identicons/#{email_hash}.png"
    end
  end
end
