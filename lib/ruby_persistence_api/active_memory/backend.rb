# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveMemory

    class Backend < Abstract::Backend

      attr_accessor :root, :transactions

      def initialize
        self.root = { }
        self.transactions = []
      end

      def connect!
        # Do nothing as this is a memory backend
      end

      def transaction
        begin_transaction
        begin
          yield
        rescue Rollback
          rollback_transaction
        rescue Exception
          rollback_transaction
          raise
        end
      end

      private

      def deep_copy(object)
        Marshal.load(Marshal.dump(object))
      end

      def begin_transaction
        transactions << deep_copy(root)
      end

      def rollback_transaction
        self.root = transactions.pop
      end

    end

  end

end
