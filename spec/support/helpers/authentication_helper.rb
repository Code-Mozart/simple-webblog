module AuthenticationHelper
  def authenticate_with_current_driver
    page.driver.header "AUTHORIZATION", encoded_credentials
  end

  def get_authentication_header
    { "HTTP_AUTHORIZATION": encoded_credentials }
  end

  def encoded_credentials
    credentials = Rails.application.credentials
    ActionController::HttpAuthentication::Basic.encode_credentials(
      credentials.dig(:basic_authentication, :name),
      credentials.dig(:basic_authentication, :password),
    )
  end
end
