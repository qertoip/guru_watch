# -*- coding: UTF-8 -*-

require 'rake/testtask'

Rake::TestTask.new( 'test:lib:use_cases_api' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/lib/use_cases_api/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:lib:entities_api' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/lib/entities_api/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:lib:ruby_persistence_api' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/lib/ruby_persistence_api/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:app:entities' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/app/entities/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:app:use_cases' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/app/use_cases/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:app:frontends' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/app/frontends/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:app:backends' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/app/backends/**/*_test.rb']
  t.verbose = false
end

desc 'Run tests for test:lib:entities_api + test:lib:use_cases_api + test:lib:ruby_persistence_api'
task 'test:lib' => ['test:lib:entities_api', 'test:lib:use_cases_api', 'test:lib:ruby_persistence_api']

desc 'Run tests for test:app:entities + test:app:use_cases + test:app:frontends + test:app:backends'
task 'test:app' => ['test:app:entities', 'test:app:use_cases', 'test:app:frontends', 'test:app:backends']

desc 'Run tests for test:lib + test:app'
task test: ['test:lib', 'test:app']

task default: :test

FileList['**/*.rake'].each do |task_file|
  load( File.expand_path( task_file ) )
end
