require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new :test do |t|
  t.libs << 'test'
  t.pattern = "test/omnipass/*_test.rb"
end

task default: :test