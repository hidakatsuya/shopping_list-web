# frozen_string_literal: true

require 'google_id_token_payload'

module Mobile
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user!

    def create
      payload = GoogleIdTokenPayload.load_from(
        params[:id_token],
        google_client_id: ENV['GOOGLE_CLIENT_ID']
      )

      user = payload&.uid.present? && User.find_by(uid: payload.uid)

      if user.present?
        sign_in user
        redirect_to items_path
      else
        redirect_to mobile_sign_in_path
      end
    end
  end
end
