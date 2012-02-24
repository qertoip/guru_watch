# -*- coding: UTF-8 -*-

ENV['APP_ENV'] = 'test'

require_relative( '../app/application' )
require_relative( '../app/backends/memory/all' )
require_relative( '../app/backends/activerecord/all' )

require 'minitest/autorun'

require 'minitest/reporters'                                                   # |\
MiniTest::Unit.runner = MiniTest::SuiteRunner.new                              # | > RubyMine integration
MiniTest::Unit.runner.reporters << MiniTest::Reporters::RubyMineReporter.new   # |/

require 'mocha'

require 'minitest_enhancements/all'

require 'factories/all'
