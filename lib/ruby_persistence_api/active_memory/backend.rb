# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveMemory

    class Backend < Abstract::Backend

      attr_accessor :databases, :transactions

      def initialize
        self.databases = { 'default' => {} }
        self.transactions = []
      end

      def connect!(config = {})
        @current_database = config[:database] || 'default'
      end

      def create_database(config)
        database = config[:database] || (raise ':database key missing')
        databases[database] = {}
      end

      def destroy_database(config)
        database = config[:database] || (raise ':database key missing')
        databases.remove(database)
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

      def root
        databases[@current_database]
      end

      def root=(new_root)
        databases[@current_database] = new_root
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
