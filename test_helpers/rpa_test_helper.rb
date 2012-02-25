# -*- coding: UTF-8 -*-

ENV['APP_ENV'] = 'active_record'
#ENV['APP_ENV'] = 'active_memory'

require_relative( '../test/lib/ruby_persistence_api/concrete/app/application' )

require 'minitest/autorun'

#require 'minitest/reporters'                                                   # |\
#MiniTest::Unit.runner = MiniTest::SuiteRunner.new                              # | > RubyMine integration
#MiniTest::Unit.runner.reporters << MiniTest::Reporters::RubyMineReporter.new   # |/

require 'mocha'

module RubyPersistenceAPI
  class TestCase < ActiveSupport::TestCase
    def db
      RubyPersistenceAPI::Application.instance.config.backend
    end
  end
end
