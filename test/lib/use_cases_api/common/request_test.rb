# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class RequestTest < GuruWatch::TestCase

    class M_initilize < self

      test 'initializes with a Hash' do
        request = Request.new(xxx: 2, s: 'New frontiers')
        assert_equal(2, request.xxx)
        assert_equal('New frontiers', request.s)
      end

    end

  end

end
