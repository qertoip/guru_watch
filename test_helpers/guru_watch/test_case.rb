# -*- coding: UTF-8 -*-

module GuruWatch

  class TestCase < ActiveSupport::TestCase

    def db
      Application.instance.config.backend
    end

    def run_with_transaction_rollback( *args )
      ret_value = nil

      db.transaction do
        # Taken from here https://github.com/seattlerb/minitest/blob/master/lib/minitest/unit.rb#L925
        ret_value = run_without_transaction_rollback( *args )
        raise RubyPersistenceAPI::Rollback
      end

      ret_value  # The result of run must be always returned for formatters to work correctly
    end
    alias_method_chain :run, :transaction_rollback

  end

end
