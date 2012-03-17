namespace :ar do
  namespace :db do
    desc 'Migrate the active_record database (options: VERSION=x, VERBOSE=false).'
    task :migrate do |t, args|
      args.with_defaults(:env => 'development')

      require_relative '../all'
      active_record_config = Backends::ActiveRecord::Config.load(args.env)
      db = RubyPersistenceAPI::ActiveRecord::Backend.new
      db.connect!(active_record_config)

      verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == 'true' : true
      version = ENV['VERSION'] ? ENV['VERSION'].to_i : nil

      ActiveRecord::Migration.verbose = verbose
      ActiveRecord::Migrator.migrations_paths = Backends::ActiveRecord::Config.migrations_paths
      ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, version) do |migration|
        ENV['SCOPE'].blank? || (ENV['SCOPE'] == migration.scope)
      end
    end
  end
end
