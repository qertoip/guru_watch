# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Entities

    class Entity
      include ActiveAttr::Model

      def persisted?
        !(new_record? || destroyed?)
      end

      def new_record?
        id.nil?  # TODO: this assumes only db manages ids
      end

      def destroyed?
        @destroyed
      end
    end

  end

end
