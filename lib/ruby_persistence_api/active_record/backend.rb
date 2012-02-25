# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  module ActiveRecord

    class Backend < Abstract::Backend

      def establish_connection
        ::ActiveRecord::Base.establish_connection(configs_for_environment.first)
      end

      def transaction
        begin
          ::ActiveRecord::Base.transaction do
            yield
          end
        rescue Rollback
          # Do nothing - transaction is already rolled back by ActiveRecord.
          # RubyPersistenceAPI::Rollback is a special exception used to force
          # transaction rollback and it is meant to be swallowed.
        end
      end

      private

        def load_config
          require 'erb'
          # paths = Application.instance.config.paths
          paths = {
              'config/database' => ["#{Application.instance.root}/config/backends/active_record.yml"],
              'db/migrate' => ["#{Application.instance.root}/app/backends/active_record/migrations"]
          }

          database_configuration = YAML::load(ERB.new(IO.read(paths['config/database'].first)).result)
          ::ActiveRecord::Base.configurations = database_configuration
          ::ActiveRecord::Migrator.migrations_paths = paths['db/migrate'].to_a
        end

        def configs_for_environment
          load_config
          environments = [Application.instance.env]
          environments << 'test' if Application.instance.env == 'development'
          ::ActiveRecord::Base.configurations.values_at(*environments).compact.reject { |config| config['database'].blank? }
        end

    end

  end

end
