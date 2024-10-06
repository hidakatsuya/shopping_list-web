# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include LocaleSwitchable

  helper_method :turbo_native?

  # For using OmniAuth without other authentications
  # https://github.com/heartcombo/devise/wiki/OmniAuth%3A-Overview#using-omniauth-without-other-authentications
  def new_session_path(scope)
    new_user_session_path
  end

  def after_sign_out_path_for(_scope)
    new_user_session_path
  end

  def turbo_native?
    ua = request&.user_agent || ""
    ua.include?("Turbo Native")
  end
end
