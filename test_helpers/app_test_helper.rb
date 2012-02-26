# -*- coding: UTF-8 -*-

ENV['APP_ENV'] = 'test'

require_relative( '../app/application' )

require 'minitest/autorun'

require 'mocha'

require 'guru_watch/test_case'

require 'factories/all'
