# -*- coding: UTF-8 -*-

require_relative( '../app/application' )

require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::RubyMineReporter.new

require 'mocha'

require_relative 'minitest_enhancements/all'

require 'factories/all'
