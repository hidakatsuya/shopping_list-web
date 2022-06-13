class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :authenticate!

  rescue_from WeakParameters::ValidationError do |e|
    respond_error :bad_request, e.message
  end

  wrap_parameters false

  private

  attr_reader :current_user

  def authenticate!
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = ::Token.find_by(value: token)&.user
    end
  end

  def respond_object(object, status = :ok)
    render json: object, status: status
  end

  def respond_error(status, message)
    respond_object({ message: message }, status)
  end
end
