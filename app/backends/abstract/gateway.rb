# -*- coding: UTF-8 -*-

module Backends

  module Abstract

    class Gateway

      attr_accessor :backend

      def initialize( backend )
        self.backend = backend
      end

    end

  end

end
