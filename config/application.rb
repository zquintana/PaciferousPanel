require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PaciferousPanel
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

    # config.assets.paths << Rails.root.join('vendor', 'assets', 'components')

    config.to_prepare do
      Devise::SessionsController.layout "middle-column" 
      Devise::RegistrationsController.layout "middle-column" 
      Devise::ConfirmationsController.layout "middle-column" 
      Devise::UnlocksController.layout "middle-column" 
      Devise::PasswordsController.layout "middle-column" 
    end

    # security_class = java.lang.Class.for_name('javax.crypto.JceSecurity')
    # restricted_field = security_class.get_declared_field('isRestricted')
    # restricted_field.accessible = true
    # restricted_field.set nil, false
  end
end


