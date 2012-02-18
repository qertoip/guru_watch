# -*- coding: UTF-8 -*-

module Backends

  module Validations

    class UniquenessValidator < ActiveModel::EachValidator

      def validate_each( record, attribute, value )
        from = record.class.name.demodulize.tableize.to_sym
        db = record.send( :db ) # hack to retrieve otherwise private db; entity needs db to check if it's unique
        if db.from( from ).where( attribute => value ).where_not( :id => record.id ).first
          record.errors.add( attribute, :taken, options.merge( :value => value ) )
        end
      end

    end

  end

end
