# -*- coding: UTF-8 -*-

ENV['APP_ENV'] = 'test'

require_relative( '../app/frontends/web/config/environment' )

require 'minitest/autorun'

require 'minitest_enhancements/all'

require 'factories/all'
