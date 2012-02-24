# Load the rails-based web frontend
require File.expand_path('../application', __FILE__)

# Initialize the rails-based web frontend
Web::Application.initialize!

if Rails.env.development?
  UseCases::SeedDatabase.new.exec
end
