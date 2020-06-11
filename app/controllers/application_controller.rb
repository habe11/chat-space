class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # CSRF対策
  # すべてのフォームとAjaxリクエストにセキュリティトークンが自動的に含まれる。
  # セキュリティトークンがマッチしない場合には例外がスロー
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end



end
