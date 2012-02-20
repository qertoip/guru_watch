# -*- coding: UTF-8 -*-

module Backends

  module Memory

    class Backend < Abstract::Backend

      attr_accessor :root, :transactions

      def initialize
        self.root = {}
        self.transactions = []
      end

      alias_method :objects, :object

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

      def save( entity )
        gateway = deduce_gateway_from( entity.class )
        gateway.save( entity )
      end

      def save!( entity )
        gateway = deduce_gateway_from( entity.class )
        gateway.save!( entity )
      end

      def save_without_validation( entity )
        gateway = deduce_gateway_from( entity.class )
        gateway.save_without_validation( entity )
      end

      def deep_copy( object )
        Marshal.load( Marshal.dump( object ) )
      end

      private

        def begin_transaction
          transactions << deep_copy( root )
        end

        def rollback_transaction
          self.root = transactions.pop
        end

    end

  end

end
