# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveMemory

    module SaveGateway

      def save_without_validation
        class_name = entity.class.name

        hash = entity_to_hash( entity )
        hashes = ( root[class_name] ||= [] )

        if entity.id.nil?
          id = new_id( hashes )
          hash['id'] = id
          entity.id = id
          hashes << hash
        else
          update_hashes( hashes, hash )
        end

        nil
      end

      def save
        if entity.valid?
          save_without_validation
          true
        else
          false
        end
      end

      def save!
        if entity.valid?
          save_without_validation
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

        def update_hashes( hashes, hash )
          existing_hash = hashes.find{ |h| h['id'] == hash['id'] }
          hashes.delete( existing_hash )
          hashes << hash
        end

    end

  end

end
