# -*- coding: UTF-8 -*-

ENV['APP_ENV'] = 'test'

require_relative( '../app/frontends/web/config/environment' )

require 'minitest/autorun'

require 'guru_watch/test_case'

require 'factories/all'
