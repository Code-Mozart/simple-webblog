class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate

  def authenticate
    http_basic_authenticate_or_request_with(
      name: Rails.application.credentials.dig(:basic_authentication, :name),
      password: Rails.application.credentials.dig(:basic_authentication, :password),
    )
  end
end
