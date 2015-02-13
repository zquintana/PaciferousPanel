class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  def require_admin!
  	return if current_user.is_admin? == true

  	redirect_to dash_url
  end

  def require_installed!
  	return if is_installed?

  	redirect_to install_start_url
  end

  def is_installed?
  	Setting.get('installed', false)
  end
end
