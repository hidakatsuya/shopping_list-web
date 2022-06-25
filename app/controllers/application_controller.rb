class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # For using OmniAuth without other authentications
  # https://github.com/heartcombo/devise/wiki/OmniAuth%3A-Overview#using-omniauth-without-other-authentications
  def new_session_path(scope)
    new_user_session_path
  end
end
