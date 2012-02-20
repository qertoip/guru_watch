# -*- coding: UTF-8 -*-

module Backends

  module Memory

    class GuruGateway < Gateway

      entity_class Entities::Guru
      attr_persistent :id, :name, :homepage, :description

    end

  end

end
