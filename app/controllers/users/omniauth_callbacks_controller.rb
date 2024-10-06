# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :google_oauth2

    def google_oauth2
      attributes = user_auth_attributes(request.env["omniauth.auth"])

      @user = User.from_omniauth(
        **attributes,
        create_user: registarable?(attributes[:email])
      )

      unless @user
        redirect_to new_user_session_url, alert: t("omniauth_callbacks.sign_in_failed")
        return
      end

      if @user&.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to new_user_session_url, alert: @user.errors.full_messages.join("\n")
      end
    end

    def failure
      redirect_to root_path
    end

    private

    def user_auth_attributes(auth)
      {
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email
      }
    end

    def registarable?(email)
      registerable_emails = Rails.configuration.registrable_account_emails.presence&.split(" ")
      registerable_emails.present? && registerable_emails.include?(email)
    end
  end
end
