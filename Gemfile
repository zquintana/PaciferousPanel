source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
# Use sqlite3 as the database for Active Record
# gem 'activerecord-jdbcsqlite3-adapter', '~> 1.3.10'
gem 'sqlite3'
# Use SCSS for stylesheets

gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'compass-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# gem 'warbler'

gem 'devise'

gem "slim-rails"

gem 'foundation-rails'

gem "font-awesome-rails"

gem 'random_password_generator', '~> 1.0.0'

group :development do
	gem 'capistrano', '~> 3.1.0'

	# rails specific capistrano funcitons
	gem 'capistrano-rails', '~> 1.1.0'

	# integrate bundler with capistrano
	gem 'capistrano-bundler'

	# if you are using RBENV
	gem 'capistrano-rbenv', "~> 2.0" 

	gem 'capistrano-passenger'
end

group :production do
  gem 'mysql2'  
end