# -*- coding: UTF-8 -*-

require 'app_test_helper'

module UseCases

  class ResponseTest < GuruWatch::TestCase

    class M_initilize < self

      test 'initializes with a Hash' do
        response = Response.new(xxx: 2, s: 'New frontiers')
        assert_equal(2, response.xxx)
        assert_equal('New frontiers', response.s)
      end

    end


    class M_ok < self

      test 'returns true if there are no errors' do
        response = Response.new(something: 'whatever')
        assert(response.ok?)
      end

      test 'returns false if there are errors' do
        response = Response.new(something: 'whatever', errors: 'some errors')
        refute(response.ok?)
      end

    end

  end

end
