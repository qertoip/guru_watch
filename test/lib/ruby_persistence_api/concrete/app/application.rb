# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  class Application

    require 'singleton'
    include Singleton

    def initialize!
      require_stdlib
      require_bundler_default_group
      require_app
      init_backend
    end

    def config
      @config ||= OpenStruct.new
    end

    def env
      ENV['BACKEND']
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

      def require_app
        require_relative 'entities/all'
      end

      def init_active_memory_backend
        $stdout.puts( 'Initializing ActiveMemory backend...' )
        Bundler.require( :active_memory_backend )
        require_relative '../../../../../lib/ruby_persistence_api/active_memory/all'
        require_relative 'backends/active_memory/all'
        config.backend = RubyPersistenceAPI::ActiveMemory::Backend.new
      end

      def init_active_record_backend
        $stdout.puts( 'Initializing ActiveRecord backend...' )
        Bundler.require( :active_record_backend )
        require_relative '../../../../../lib/ruby_persistence_api/active_record/all'
        require_relative 'backends/active_record/all'
        config.backend = RubyPersistenceAPI::ActiveRecord::Backend.new
        config.backend.connect!(
          adapter: 'postgresql',
          encoding: 'unicode',
          database: 'ruby_persistence_api_test',
          pool: 5,
          username: 'qertoip',
          password: 'test123',
          host: 'localhost',
          port: 5432,
          min_messages: 'WARNING'
        )
        recreate_schema
      end

      def init_backend
        case env
          when 'active_memory' then init_active_memory_backend
          when 'active_record' then init_active_record_backend
          else
            raise StandardError.new( 'Unknown environment ' + env )
        end
      end

    private

      def recreate_schema
        c = ::ActiveRecord::Base.connection
        c.create_table :dogs, force: true do |t|
          t.string :name
          t.integer :age
          t.decimal :price
          t.datetime :bought_at
          t.boolean :active
        end
        c.create_table :cats, force: true do |t|
          t.string :name
          t.integer :age
        end
      end

  end

end

RubyPersistenceAPI::Application.instance.initialize!
