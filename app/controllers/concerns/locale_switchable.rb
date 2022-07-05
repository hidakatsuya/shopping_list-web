# frozen_string_literal: true

module LocaleSwitchable
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale
  end

  def switch_locale(&action)
    locale = current_user&.locale || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
