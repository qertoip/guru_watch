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
    init_backend
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
      # require_relative 'backends/api/all'
      require_relative 'entities/all'
      require_relative 'use_cases/all'
    end

    def init_active_memory_backend
      Bundler.require( :active_memory_backend )
      require_relative '../lib/ruby_persistence_api/active_memory/all'
      require_relative 'backends/active_memory/all'
      config.backend = RubyPersistenceAPI::ActiveMemory::Backend.new
    end

    def init_active_record_backend
      Bundler.require( :active_record_backend )
      require_relative '../lib/ruby_persistence_api/active_record/all'
      require_relative 'backends/active_record/all'
      config.backend = RubyPersistenceAPI::ActiveRecord::Backend.new
      config.backend.connect!( load_active_record_config )
    end

    def init_backend
      case env
        when 'test' then init_active_memory_backend
        when 'development' then init_active_memory_backend
        when 'production' then init_active_record_backend
        else
          raise StandardError.new( 'Unknown environment ' + env )
      end
    end

  private

    def load_active_record_config
      config_path = "#{root}/config/backends/active_record.yml"
      config_yaml = YAML::load(ERB.new(IO.read(config_path)).result)
      config_hash = config_yaml[env]
      config_hash
    end

end

Application.instance.initialize!
