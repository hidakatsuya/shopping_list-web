module ApplicationHelper
  def form_error_notification(model)
    render partial: 'layouts/error_notification', locals: { model: model } if model.errors.any?
  end
end
