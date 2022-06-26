# frozen_string_literal: true

class User < ApplicationRecord
  devise :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :items, dependent: :destroy
  has_one :token, dependent: :destroy

  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end
  end
end
