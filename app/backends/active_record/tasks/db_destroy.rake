
desc 'Destroy active_record database for the specified environment'
namespace :ar do
  namespace :db do
    task :destroy, [:env] do |t, args|
      args.with_defaults(:env => 'development')

      require_relative '../helpers/config'
      active_record_config = Backends::ActiveRecord::Config.load(args.env)

      require_relative '../../../../lib/ruby_persistence_api/active_record/all'
      RubyPersistenceAPI::ActiveRecord::Backend.new.destroy_database(active_record_config)
    end
  end
end
