# -*- coding: UTF-8 -*-

require 'rake/testtask'

Rake::TestTask.new( "test" ) do |t|
  t.libs << ["test", "app", "lib"]
  t.test_files = FileList["test/unit/**/*_test.rb", "test/functional/**/*_test.rb"]
  t.verbose = true
end

task :default => :test
