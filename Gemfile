source 'http://rubygems.org'

gem 'activemodel', :require => 'active_model'
gem 'activesupport', :require => 'active_support/all'
gem 'active_attr', :git => 'https://github.com/cgriego/active_attr.git'

group :default_web do
  gem 'unicorn'
  gem 'rails', '3.2.1' #, :require => false
  gem 'haml'
end

group :development_web do
end

group :production_web do
end

group :test_web do
end

gem 'rake', :require => false

group :test do
  gem 'minitest', :require => false
  gem 'minitest-reporters', :require => false
  gem 'mocha', :require => false
end
