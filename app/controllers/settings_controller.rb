# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :set_setting

  def edit
  end

  def update
    @setting.assign_attributes(setting_params)

    if @setting.save
      redirect_to settings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_setting
    @setting = current_user.setting || current_user.build_setting
  end

  def setting_params
    params.require(:setting).permit(:locale)
  end
end
