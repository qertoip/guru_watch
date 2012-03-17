# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveRecord

    class DatabaseDestroyer

      attr_accessor :config

      def initialize(config)
        self.config = config
      end

      # Copied from ActiveRecord-3.2.2/lib/active_record/railties/databases.rake
      def destroy_database
        case config['adapter']
          when /mysql/
            ::ActiveRecord::Base.establish_connection(config)
            ::ActiveRecord::Base.connection.drop_database config['database']
          when /sqlite/
            require 'pathname'
            path = Pathname.new(config['database'])
            file = path.absolute? ? path.to_s : File.join(Rails.root, path)
            FileUtils.rm(file)
          when /postgresql/
            ::ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
            ::ActiveRecord::Base.connection.drop_database config['database']
        end
      end

    end

  end

end
