# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class TransactionTest < RubyPersistenceAPI::TestCase

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
      db.transaction do
        raise RubyPersistenceAPI::Rollback
      end
    end

    private

      def assert_rollback_on( exception_class )
        dog_name = 'some unique dog name'
        dog_class = Entities::Dog
        block_executed = false
        begin
          db.transaction do
            dog = dog_class.new( :name => dog_name )
            db[dog].save!
            assert( db[dog_class].where( :name => dog_name ).first )
            block_executed = true
            raise exception_class
          end
        rescue exception_class => e
          assert( block_executed, "Block didn't executed: #{e.message}" )
          assert_nil( db[dog_class].where( :name => dog_name ).first )
        end
      end

  end

end
