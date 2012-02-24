# -*- coding: UTF-8 -*-

module Backends

  module Validations

    class UniquenessValidator < ActiveModel::EachValidator

      def validate_each( object, attribute, value )
        db = Application.instance.config.backend # hack to retrieve otherwise private db; entity needs db to check if it's unique
        if db[object.class].where( attribute => value ).where_not( :id => object.id ).first
          object.errors.add( attribute, :taken, options.merge( :value => value ) )
        end
      end

    end

  end

end
