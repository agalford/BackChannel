source 'http://rubygems.org'

gem 'rails', '3.1.1.rc1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'devise'
gem 'test-unit'
#gem "pg"

group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sqlite3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier', '>= 1.0.3'
end

# this fixes a problem with the execjs on windows 1.2.6/1.2.7
# see "https://github.com/sstephenson/execjs/issues/48"
# also 1.2.8 should work, 1.2.7 on the other hand sucks
gem 'execjs', '1.2.8'

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end