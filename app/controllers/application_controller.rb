class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_filter :get_all_tags

  def get_all_tags
    @alltags = ActsAsTaggableOn::Tag.all
  end
end
