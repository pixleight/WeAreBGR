module SessionsHelper

  # Handle signin and storing remember tokens
  def sign_in(creator)
    remember_token = Creator.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    creator.update_attribute(:remember_token, Creator.digest(remember_token))
    self.current_creator = creator
  end

  # Check if creator is signed in
  def signed_in?
    !current_creator.nil?
  end

  # Assign the current creator
  def current_creator=(creator)
    @current_creator = creator
  end

  # Get the current creator by remember token
  def current_creator
    remember_token = Creator.digest(cookies[:remember_token])
    @current_creator ||= Creator.find_by(remember_token: remember_token)
  end

  # Sign out
  def sign_out
    current_creator.update_attribute(:remember_token, Creator.digest(Creator.new_remember_token))
    cookies.delete(:remember_token)
    self.current_creator = nil
  end
end
