class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_admin!
  	return if current_user.is_admin? == true

  	redirect_to dash_url
  end
end
