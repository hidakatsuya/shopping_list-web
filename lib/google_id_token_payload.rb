# frozen_string_literal: true

# This is a class that validates and parses Google IdToken and extracts user_id (sub).
#
# Details of the Google IdToken payload:
# https://developers.google.com/identity/protocols/oauth2/openid-connect#an-id-tokens-payload
#
class GoogleIdTokenPayload
  class << self
    def load_from(id_token, google_client_id:)
      validator = GoogleIDToken::Validator.new
      payload = validator.check(id_token, google_client_id)

      new payload
    rescue GoogleIDToken::ValidationError => e
      Rails.logger.error "Failed to verify token: #{e}"
      nil
    end
  end

  def initialize(id_token_payload)
    @payload = id_token_payload || {}
  end

  # User#uid is set to the sub attribute of Google IdToken.
  # See OmniAuth::Strategies:
  # https://github.com/zquestz/omniauth-google-oauth2/blob/665a8ccd4c5a65395da9a84fe4790406ede9ddff/lib/omniauth/strategies/google_oauth2.rb#L46
  def uid
    @payload['sub']
  end
end
