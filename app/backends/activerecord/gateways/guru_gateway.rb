# -*- coding: UTF-8 -*-

module Backends

  module ActiveRecord

    class GuruGateway < Gateway

      entity_class Entities::Guru
      class Model < ::ActiveRecord::Base; end

    end

  end

end
