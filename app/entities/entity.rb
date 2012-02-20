# -*- coding: UTF-8 -*-

module Entities

  class Entity
    include ActiveModel::Validations
    include ActiveModel::Conversion   # adds #to_key and #to_param
    include Backends::Validations
    include Backends::EntityState     # adds #persisted?

    def initialize( atts = {}, options = {} )
      (atts || {}).each do |attr, value|
        self.send( "#{attr}=", value )
      end
    end

  end

end
