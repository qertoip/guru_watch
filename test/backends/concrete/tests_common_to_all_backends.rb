# -*- coding: UTF-8 -*-

require 'backends_test_helper'
require 'active_support/concern'

module Backends

  module TestsCommonToAllBackends

    extend ActiveSupport::Concern

    included do

      # self == base (the class into which this module is included)

      class self::EstablishConnectionMethod < self

        def does_not_raise_exception_TEST
          @db.establish_connection
        end

      end

      class self::TransactionMethod < self

        def rollbacks_data_to_the_pre_transaction_state_on_StandardError_TEST
          assert_rollback_on( StandardError )
        end

        def rollbacks_data_to_the_pre_transaction_state_on_Exception_TEST
          assert_rollback_on( Exception )
        end

        def rollbacks_data_to_the_pre_transaction_state_on_Rollback_TEST
          assert_rollback_on( Backends::Rollback )
        end

        def swallows_Rollback_pseudo_exception_TEST
          @db.transaction do
            raise Backends::Rollback
          end
        end

        private

          def assert_rollback_on( exception_class )
            dog_name = 'some unique dog name'
            block_executed = false

            dog_class = self.class::Dog

            begin
              @db.transaction do
                dog = dog_class.new( :name => dog_name )
                @db[dog].save!
                assert( @db[dog_class].where( :name => dog_name ).first )
                block_executed = true
                raise exception_class
              end
            rescue exception_class => e
              assert( block_executed, "Block didn't executed: #{e.message}" )
              assert_nil( @db[dog_class].where( :name => dog_name ).first )
            end
          end

      end

    end

  end

end
