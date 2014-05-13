class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_filter :get_all_tags, :set_social_accounts, :set_session_seed

  private
    def get_all_tags
      @alltags = ActsAsTaggableOn::Tag.all
    end

    def set_social_accounts
      @social_account_list = {
        'globe' => 'Website',
        'facebook' => 'Facebook',
        'twitter' =>  'Twitter',
        'linkedin' => 'LinkedIn',
        'google-plus' => "Google Plus",
        'tumblr' => 'Tumblr',
        'instagram' => 'Instagram',
        'flickr' => 'Flickr',
        'youtube' => 'YouTube',
        'github' => 'GitHub',
        'dribbble' => 'Dribbble'
      }
    end

    def set_session_seed
      cookies[:random_seed] ||= rand(1024)
    end
end
