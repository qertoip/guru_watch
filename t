echo
echo
echo 'Library / Entities API'
echo '-------------------------------------------------------------------------------------'
bundle exec rake test:lib:entities_api

echo
echo
echo 'Library / Use Cases API'
echo '-------------------------------------------------------------------------------------'
bundle exec rake test:lib:use_cases_api

echo
echo
echo 'Library / Ruby Persistence API with ActiveMemory Backend'
echo '-------------------------------------------------------------------------------------'
bundle exec rake test:lib:ruby_persistence_api BACKEND=active_memory

echo
echo
echo 'Library / Ruby Persistence API with ActiveRecord Backend'
echo '-------------------------------------------------------------------------------------'
bundle exec rake test:lib:ruby_persistence_api BACKEND=active_record

echo
echo
echo 'Application / Entities'
echo '-------------------------------------------------------------------------------------'
bundle exec rake test:app:entities

echo
echo
echo 'Application / Use Cases'
echo '-------------------------------------------------------------------------------------'
bundle exec rake test:app:use_cases

echo
echo
echo 'Application / Frontends'
echo '-------------------------------------------------------------------------------------'
bundle exec rake test:app:frontends

echo
echo
echo 'Application / Backends'
echo '-------------------------------------------------------------------------------------'
bundle exec rake test:app:backends
