# -*- coding: UTF-8 -*-

module Backends

  module Memory

    module SaveGateway

      def save_without_validation( entity )
        class_name = entity.class.name

        hash = entity_to_hash( entity )
        hashes = ( root[class_name] ||= [] )

        if entity.id.nil?
          id = new_id( hashes )
          hash['id'] = id
          entity.id = id
        end

        hashes << hash

        nil
      end

      def save( entity )
        if entity.valid?
          save_without_validation( entity )
          true
        else
          false
        end
      end

      def save!( entity )
        if entity.valid?
          save_without_validation( entity )
          true
        else
          raise ObjectInvalid.new( entity.errors.inspect )
        end
      end

      private

        def new_id( existing_hashes )
          begin
            rand_id = rand( 2**31 )
          end while existing_hashes.map{ |h| h['id'] }.include?( rand_id )

          rand_id
        end

    end

  end

end
