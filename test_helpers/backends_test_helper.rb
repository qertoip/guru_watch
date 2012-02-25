# -*- coding: UTF-8 -*-

ENV['APP_ENV'] = 'test'

require_relative( '../app/application' )
#require_relative( '../app/backends/active_memory/all' )
#require_relative( '../app/backends/active_record/all' )

def backend_modules
  [::RubyPersistenceAPI::ActiveMemory]
  # [::RubyPersistenceAPI::Memory, ::RubyPersistenceAPI::ActiveRecord]
end

require 'minitest/autorun'

#require 'minitest/reporters'                                                   # |\
#MiniTest::Unit.runner = MiniTest::SuiteRunner.new                              # | > RubyMine integration
#MiniTest::Unit.runner.reporters << MiniTest::Reporters::RubyMineReporter.new   # |/

require 'mocha'

require 'minitest_enhancements/all'
require 'factories/all'
