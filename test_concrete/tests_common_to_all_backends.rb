# -*- coding: UTF-8 -*-

require 'backends_test_helper'
require 'active_support/concern'

module Backends

  module TestsCommonToAllBackends

    extend ActiveSupport::Concern

    included do

      # self == base (the class into which this module is included)

      class self::M_establish_connection < self

        test 'does_not_raise_exception' do
          @db.establish_connection
        end

      end

      class self::M_transaction < self

        test 'rollbacks_data_to_the_pre_transaction_state_on_StandardError' do
          assert_rollback_on( StandardError )
        end

        test 'rollbacks_data_to_the_pre_transaction_state_on_Exception' do
          assert_rollback_on( Exception )
        end

        test 'rollbacks_data_to_the_pre_transaction_state_on_Rollback' do
          assert_rollback_on( RubyPersistenceAPI::Rollback )
        end

        test 'swallows_Rollback_pseudo_exception' do
          @db.transaction do
            raise RubyPersistenceAPI::Rollback
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
