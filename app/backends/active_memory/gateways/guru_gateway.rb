# -*- coding: UTF-8 -*-

module Backends

  module ActiveMemory

    class GuruGateway < RubyPersistenceAPI::ActiveMemory::Gateway

      entity_class Entities::Guru

    end

  end

end
