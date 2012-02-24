# -*- coding: UTF-8 -*-

# This loads the application *without* any frontend.
# To run a specific *fronted* (like a web app) go to app/frontends/*.

class Application

  require 'singleton'
  include Singleton

  def initialize!
    require_stdlib
    require_bundler_default_group
    require_lib
    require_app
    require_backend
    connect_to_database
  end

  def config
    @config ||= OpenStruct.new
  end

  def env
    ENV['APP_ENV']
  end

  def root
    File.expand_path( "#{File.dirname( __FILE__ )}/../" )
  end

  private

    def require_stdlib
      require 'ostruct'
    end

    def require_bundler_default_group
      Bundler.require( :default )
    end

    def require_lib
      require_relative '../lib/all'
    end

    def require_app
      require_relative 'backends/api/all'
      require_relative 'entities/all'
      require_relative 'use_cases/all'
    end

    def require_backend
      case env
        when 'test'
          require_relative 'backends/memory/all'
          config.backend = Backends::Memory::Backend.new
        when 'development'
          require_relative 'backends/memory/all'
          config.backend = Backends::Memory::Backend.new
        when 'production'
          require_relative 'backends/activerecord/all'
          config.backend = Backends::ActiveRecord::Backend.new
        else
          raise StandardError.new( 'Unknown environment ' + env )
      end
    end

    def connect_to_database
      config.backend.establish_connection
    end
end

Application.instance.initialize!
