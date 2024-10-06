# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :set_setting
  before_action :set_token, only: [ :edit ]

  def edit
  end

  def update_setting
    @setting.assign_attributes(setting_params)

    if @setting.save
      redirect_to settings_path
    else
      respond_to do |format|
        format.turbo_stream
        format.html {
          set_token
          render :edit
        }
      end
    end
  end

  private

  def set_token
    @token = current_user.token || current_user.build_token
  end

  def set_setting
    @setting = current_user.setting || current_user.build_setting
  end

  def setting_params
    params.require(:setting).permit(:locale)
  end
end
