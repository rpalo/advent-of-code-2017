# frozen_string_literal: true

require 'erb'
require 'rake/testtask'

desc "Run tests"
Rake::TestTask.new do |t|
  t.libs = ["lib", "test"]
  t.test_files = FileList['test/**/*_test.rb']
end

#       *
#      +++
#     *++*+
#    +++*++*
#  MERRY XMAS!

desc "Prints a secret message!"
task :secret do
  days = FileList['challenges/**/day*.rb'].to_a.sort_by do |filename|
    filename.scan(/[0-9]+/).first.to_i
  end
  secret = days.reduce([]) do |accum, day|
    accum << File.open(day).to_a.last.delete("#").chomp
  end
  puts secret.join.split(".").join("\n")
end

desc "Runs the specified script against input.txt"
task :run, [:day] do |t, args|
  day = args[:day]
  ruby "challenges/day#{day}.rb challenges/input.txt"
end

desc "Generates a new task from template"
task :new, [:day, :cls] do |t, args|
  day = args[:day]
  cls = args[:cls]
  files = ['day.rb.erb', 'cls.rb.erb', 'cls_test.rb.erb']
  day_template = File.read('templates/day.rb.erb')
  cls_template = File.read('templates/cls.rb.erb')
  cls_test_template = File.read('templates/cls_test.rb.erb')

  proper_cls = cls.split('_').map(&:capitalize).join

  day_out = ERB.new(day_template).result(binding)
  cls_out = ERB.new(cls_template).result(binding)
  cls_test_out = ERB.new(cls_test_template).result(binding)

  puts " + Creating day#{day}.rb in challenges folder..."
  File.open("challenges/day#{day}.rb", 'w') { |f| f.puts day_out }
  puts " + Creating #{cls}.rb in lib folder..."
  File.open("lib/#{cls}.rb", 'w') { |f| f.puts cls_out }
  puts " + Creating #{cls}_test.rb in test folder..."
  File.open("test/#{cls}_test.rb", 'w') { |f| f.puts cls_test_out }
  puts "====="
  puts "Day #{day} files generated!"
end

task default: [:test]
