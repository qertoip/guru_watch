# -*- coding: UTF-8 -*-

# This loads the application *without* any frontend.
# To run a specific *fronted* (like a web app) go to app/frontends/*.

class Application

  require 'singleton'
  include Singleton

  def initialize!
    require_stdlib
    require_bundler_default_group
    augment_load_path
    require_lib
    require_app
    init_backend
  end

  def config
    @config ||= OpenStruct.new
  end

  def env
    ENV['APP_ENV'] || 'development'
  end

  def root
    File.expand_path("#{File.dirname(__FILE__)}/../")
  end

  private

  def require_stdlib
    require 'ostruct'
  end

  def require_bundler_default_group
    Bundler.require(:default)
  end

  def require_lib
    require_relative '../lib/all'
  end

  def augment_load_path
    libpath = File.expand_path( File.dirname( __FILE__ ) + '../../lib' )
    $LOAD_PATH << libpath
  end

  def require_app
    require_relative 'entities/all'
    require_relative 'use_cases/all'
  end

  def init_active_memory_backend
    require_relative 'backends/active_memory/all'
    config.backend = RubyPersistenceAPI::ActiveMemory::Backend.new
    config.backend.connect!
  end

  def init_active_record_backend
    require_relative 'backends/active_record/all'
    config.backend = RubyPersistenceAPI::ActiveRecord::Backend.new
    active_record_config = Backends::ActiveRecord::Config.load(env)
    config.backend.connect!(active_record_config)
  end

  def init_backend
    case env
      when 'test' then
        init_active_memory_backend
      when 'development' then
        init_active_memory_backend
      when 'production' then
        init_active_record_backend
      else
        raise StandardError.new('Unknown environment ' + env)
    end
  end

end

Application.instance.initialize!
