# -*- coding: UTF-8 -*-

require 'rake/testtask'

Rake::TestTask.new( "test" ) do |t|
  t.libs << ["app", "lib", "test_helpers"]
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

task :default => :test
