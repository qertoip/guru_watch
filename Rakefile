# -*- coding: UTF-8 -*-

require 'rake/testtask'

Rake::TestTask.new( 'test:lib' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/lib/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:entities' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/app/entities/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:use_cases' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/app/use_cases/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:frontends' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/app/frontends/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new( 'test:backends' ) do |t|
  t.libs << ['app', 'lib', 'test_helpers']
  t.test_files = FileList['test/app/backends/**/*_test.rb']
  t.verbose = false
end

desc 'Run tests for test:entities + test:use_cases + test:frontends + test:backends'
task 'test:app' => ['test:entities', 'test:use_cases', 'test:frontends', 'test:backends']

desc 'Run tests for test:lib + test:app'
task test: ['test:lib', 'test:app']

task default: :test

FileList['**/*.rake'].each do |task_file|
  load( File.expand_path( task_file ) )
end
