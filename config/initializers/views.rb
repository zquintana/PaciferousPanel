module PaciferousPanel
	class Application
		ActionView::Base.default_form_builder = FaFormBuilder
	end
end

module Renderer

  	# Renders a view.
  	def self.render options = {}

    	# Pass a hash of local variables as :assigns.
    	assigns = options.delete(:assigns) || {}

    	# Create a view.
    	view = view_class.new ActionController::Base.view_paths, assigns

    	# Mix in other helpers you need.
    	view.extend ApplicationHelper
    	# view.extend CustomHelper

    	# Render.
    	view.render options
  	end

  	# Creates a subclass of ActionView::Base with route helpers mixed in.
  	def self.view_class
    	@view_class ||= Class.new ActionView::Base do
      		include Rails.application.routes.url_helpers
    	end
  	end
end

# Use like:
# Renderer.render template: 'user/show', assigns: { user: @user }