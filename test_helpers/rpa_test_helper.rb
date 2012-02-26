# -*- coding: UTF-8 -*-

ENV['BACKEND'] = 'active_memory' unless ENV['BACKEND']

require_relative( '../test/lib/ruby_persistence_api/concrete/app/application' )

require 'minitest/autorun'

require 'mocha'

require 'ruby_persistence_api/test_case'
