# -*- coding: UTF-8 -*-

require 'backends_test_helper'
require_relative 'tests_common_to_all_backends'

module Backends

  module Memory

    class BackendTest < ActiveSupport::TestCase

      class Dog < Entities::Entity
        attribute :id, :type => Integer
        attribute :name, :type => String
        attribute :age, :type => Integer
      end

      class DogGateway < Gateway
        entity_class Dog
      end

      def setup
        @db = Backend.new
        @db.establish_connection
      end

      include TestsCommonToAllBackends

    end

  end

end
