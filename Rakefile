require 'rake/testtask'

desc "Run tests"
Rake::TestTask.new do |t|
  t.test_files = FileList['challenges/**/*_test.rb']
end

task default: [:test]