require 'rake/testtask'

desc "Run tests"
Rake::TestTask.new do |t|
  t.test_files = FileList['challenges/**/*_test.rb']
end

#       *
#      +++
#     *++*+
#    +++*++*
#  MERRY XMAS!

desc "Prints a secret message!"
task :secret do
  days = FileList['challenges/**/day*.rb'].to_a
  secret = days.reduce("") do |accum, day|
    accum << File.open(day).to_a.last.delete("#").chomp
  end
  puts secret.split(".").join("\n")
end

task default: [:test]
