# -*- coding: UTF-8 -*-

require_relative( '../app/application' )

require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::RubyMineReporter.new

require 'mocha'

require_relative 'minitest/custom_assertions'
require_relative 'minitest/run_each_test_in_a_rolled_back_transaction'

require 'factories/all'
