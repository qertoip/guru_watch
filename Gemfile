source 'http://rubygems.org'

gem 'rake', :require => false

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Application
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

gem 'activemodel', :require => 'active_model'
gem 'activesupport', :require => 'active_support/all'
gem 'active_attr', :git => 'https://github.com/cgriego/active_attr.git'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Backends
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

group :activerecord_backend do
  gem 'pg'
  gem 'activerecord', :require => 'active_record'
end

group :memory_backend do
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Frontends
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

group :web_frontend do
  gem 'unicorn'
  gem 'rails', '3.2.1' #, :require => false
  gem 'haml'
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Tests
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

group :test do
  gem 'minitest', :require => false
  gem 'minitest-reporters', :require => false
  gem 'mocha', :require => false
end
