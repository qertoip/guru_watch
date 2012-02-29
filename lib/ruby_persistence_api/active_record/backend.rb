# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveRecord

    class Backend < Abstract::Backend

      def connect!( config )
        ::ActiveRecord::Base.establish_connection( config )
      end

      def transaction
        begin
          ::ActiveRecord::Base.transaction( requires_new: true ) do
            yield
          end
        rescue Rollback
          # Do nothing - transaction is already rolled back by ActiveRecord.
          # RubyPersistenceAPI::Rollback is a special exception used to force
          # transaction rollback and it is meant to be swallowed.
        end
      end

    end

  end

end
