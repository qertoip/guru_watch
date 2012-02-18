# -*- coding: UTF-8 -*-

module Entities

  class Entity
    include ActiveModel::Validations
    include ActiveModel::Conversion
    include Backends::Validations

    class << self
      attr_accessor :attr_persistent_array
    end

    def new_record?
      id.nil?  # TODO: this assumes only db manages ids
    end

    def destroyed?
      @destroyed
    end

    def persisted?
      !(new_record? || destroyed?)
    end

    def initialize( atts = {}, options = {} )
      (atts || {}).each do |attr, value|
        self.send( "#{attr}=", value )
      end
    end

    def marshal_dump
      if attr_persistent_array.nil? || attr_persistent_array.empty?
        raise MissingPersistentAttributes.new( "Add attr_persistent(:list, :of, :attributes) declaration to #{self.class.name}" )
      end

      hash = {}
      attr_persistent_array.each do |attr|
        hash[attr] = send( attr )
      end
      hash
    end

    def marshal_load( hash )
      hash.each do |attr, value|
        self.send( "#{attr}=", value )
      end
    end

    def self.attr_persistent( *array_of_attributes )
      self.attr_persistent_array = array_of_attributes
    end

    def self.get_attr_persistent
      attr_persistent_array
    end

    def attr_persistent_array
      self.class.attr_persistent_array
    end

    private

      def db
        GuruWatch.instance.config.backend
      end

  end

end
