class ApplicationController < ActionController::Base

  before_action :current_user
  before_action :require_sign_in!
  helper_method :signed_in?

  protect_from_forgery with: :exception

  rescue_from StandardError,
    with: lambda { |e| response_error(e) } unless Rails.env.development?
 
  def response_error(exception)
    status_code = ActionDispatch::ExceptionWrapper.new(request.env, exception).status_code

    ExceptionNotifier.logger_notify(exception, data: request.params)
    
    render json: {message: exception.message}, status: status_code
  end

  def current_user
    logger.debug(@current_user.inspect)
    remember_token = User.encrypt(cookies[:user_remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update_attributes!(remember_token: User.encrypt(remember_token))
    logger.debug(user.inspect)
    @current_user = user
  end

  def sign_out
    cookies.delete(:user_remember_token)
  end

  def signed_in?
    @current_user.present?
  end

  private

    def require_sign_in!
      redirect_to login_path unless signed_in?
    end

end
