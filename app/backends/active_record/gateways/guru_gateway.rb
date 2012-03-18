# -*- coding: UTF-8 -*-

module Backends

  module ActiveRecord

    class GuruGateway < RubyPersistenceAPI::ActiveRecord::Gateway

      class Guru < ::ActiveRecord::Base
      end

      entity_class Entities::Guru
      ar_class Guru

    end

  end

end
