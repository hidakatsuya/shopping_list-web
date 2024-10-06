# frozen_string_literal: true

module ApplicationHelper
  def form_error_notification(model, classes: [])
    return if model.errors.empty?

    render partial: "layouts/error_notification",
           locals: { model: model, classes: Array.wrap(classes) }
  end

  def not_turbo_native
    yield unless turbo_native?
  end
end
