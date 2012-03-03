# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class DestroyTest < RubyPersistenceAPI::TestCase

    include Entities

    class CalledOnNewObject < self
      test 'marks object as destroyed' do
      end

      test 'freezes the object' do
      end
    end

    class CalledOnSavedObject < self
      test 'removes the object from persistent store' do
      end

      test 'marks object as destroyed' do
      end

      test 'freezes the object' do
      end
    end

  end

end
