class DashController < ApplicationController
	before_action :require_installed!
  	before_action :authenticate_user!
  	layout "left-column"

  def index
  	@domains = current_user.is_admin? ? Domain.all : current_user.domains.all
  end

  def domain
  	@domain = current_user.is_admin? ? Domain.find(params[:id]) : current_user.domains.find(params[:id])
  end
end
