# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module Backends

    module ActiveMemory

      class DogGateway < RubyPersistenceAPI::ActiveMemory::Gateway
        entity_class Entities::Dog
      end

    end

  end

end
