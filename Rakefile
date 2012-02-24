# -*- coding: UTF-8 -*-

require 'rake/testtask'

Rake::TestTask.new( "test:backends" ) do |t|
  t.libs << ["app", "lib", "test_helpers"]
  t.test_files = FileList["test/backends/**/*_test.rb"]
  t.verbose = true
end

Rake::TestTask.new( "test:app" ) do |t|
  t.libs << ["app", "lib", "test_helpers"]
  t.test_files = FileList[#"test/backends/**/*_test.rb",
                          "test/entities/**/*_test.rb",
                          "test/use_cases/**/*_test.rb"]
  t.verbose = true
end

Rake::TestTask.new( "test:frontends" ) do |t|
  t.libs << ["app", "lib", "test_helpers"]
  t.test_files = FileList["test/frontends/**/*_test.rb"]
  t.verbose = true
end

task test: ['test:backends', 'test:app', 'test:frontends']

task default: :test
