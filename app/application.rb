# -*- coding: UTF-8 -*-

# This loads the application *without* any frontend.
# To run a specific *fronted* (like a web app) go to app/frontends/*.

Bundler.require( :default )

require_relative '../lib/all'

# Ruby requires
require 'ostruct'
require 'singleton'

class GuruWatch

  include Singleton

  class Config < OpenStruct
  end

  def config
    @config ||= Config.new
  end

end

# Application requires
require_relative 'backends/common/all'
require_relative 'backends/abstract/all'
require_relative 'entities/all'
require_relative 'use_cases/all'

# Configuration

require_relative 'backends/memory/all'
GuruWatch.instance.config.backend = Backends::Memory::Backend.new
