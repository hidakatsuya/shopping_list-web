# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # Disable all actions except destroy action because only destroy action is used.
  prepend_before_action ->{ head :not_found }, except: [:destroy]
end
