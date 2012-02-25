# -*- coding: UTF-8 -*-

require 'backends_test_helper'
require_relative 'tests_common_to_all_backends'

module Backends

  module ActiveRecord

    class BackendTest < ActiveSupport::TestCase

      class Dog < Entities::Entity
        attribute :id, :type => Integer
        attribute :name, :type => String
        attribute :age, :type => Integer
      end

      class DogGateway < Gateway
        entity_class Dog
        class Dog < ::ActiveRecord::Base; end
        def model_class
          Dog
        end
      end

      def setup
        @db = Backend.new
        @db.establish_connection
        create_schema
      end

      include TestsCommonToAllBackends

      def teardown
        drop_schema
        ::ActiveRecord::Base.connection.disconnect!
      end

      private

        def create_schema
          c = ::ActiveRecord::Base.connection
          c.create_table :dogs, :force => true do |t|
            t.string :name
            t.integer :age
          end
        end

        def drop_schema
          c = ::ActiveRecord::Base.connection
          c.drop_table :dogs
        end
    end

  end

end
