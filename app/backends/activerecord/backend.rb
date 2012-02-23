# -*- coding: UTF-8 -*-

module Backends

  module ActiveRecord

    class Backend < Abstract::Backend

      def transaction
        ActiveRecord::Base.transaction do
          yield
        end
      end

    end

  end

end
