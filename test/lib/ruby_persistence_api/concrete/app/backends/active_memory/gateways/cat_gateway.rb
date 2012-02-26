# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Backends

    module ActiveMemory

      class CatGateway < RubyPersistenceAPI::ActiveMemory::Gateway
        entity_class Entities::Cat
      end

    end

  end

end
