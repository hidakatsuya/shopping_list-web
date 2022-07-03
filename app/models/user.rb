# frozen_string_literal: true

class User < ApplicationRecord
  devise :registerable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :items, dependent: :delete_all
  has_one :token, dependent: :destroy

  validates :email, presence: true,
                    uniqueness: { case_sensitive: true, allow_blank: true },
                    format: { with: ::Devise.email_regexp, allow_blank: true }

  class << self
    def from_omniauth(provider:, uid:, email:, create_user: false)
      attributes = { provider: provider, uid: uid }

      user = find_by(attributes)
      return user if user

      if create_user
        create(attributes.merge(email: email))
      else
        nil
      end
    end
  end
end
