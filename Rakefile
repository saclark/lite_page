require 'bundler/gem_tasks'
require 'rake/testtask'
require 'coveralls/rake/task'
require 'yard'

Coveralls::RakeTask.new

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
  t.options = ['--output-dir', 'doc/app/']
end

task :default => [:test]
