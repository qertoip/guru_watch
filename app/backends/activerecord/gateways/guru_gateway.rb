# -*- coding: UTF-8 -*-

module Backends

  module ActiveRecord

    class GuruGateway < Gateway

      entity_class Entities::Guru
      class Guru < ::ActiveRecord::Base; end

      def model_class
        Guru
      end
    end

  end

end
