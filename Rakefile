# frozen_string_literal: true

require 'erb'
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
  ruby "challenges/day#{day}/day#{day}.rb challenges/input.txt"
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

  Dir.mkdir "challenges/day#{day}"
  File.open("challenges/day#{day}/day#{day}.rb", 'w') { |f| f.puts day_out }
  File.open("challenges/day#{day}/#{cls}.rb", 'w') { |f| f.puts cls_out }
  File.open("challenges/day#{day}/#{cls}_test.rb", 'w') { |f| f.puts cls_test_out }
end

task default: [:test]
