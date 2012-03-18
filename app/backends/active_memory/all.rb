# Entities
require_relative '../../entities/all'

# Gems
Bundler.require(:active_memory_backend)
require_relative '../../../lib/ruby_persistence_api/active_memory/all'

# Me
require_relative 'gateways/all'
require_relative 'backend'
