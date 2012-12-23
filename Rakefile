require 'rake'
require 'rake/testtask'

task :default => [:test_units]

desc "Run basic tests"
Rake::TestTask.new("test_units") { |t|
  t.pattern = './src/test/ruby/*Test.rb'
  t.verbose = true
  t.warning = true
}
