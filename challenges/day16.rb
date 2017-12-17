# frozen_string_literal: true

require_relative '../lib/dance'

letters = ('a'..'p').to_a.join
instructions = ARGF.read.chomp.split(',')

results = [letters]
# Part 1: Dance once
instructions.each do |instruction|
  letters = Dance.read(instruction, letters)
end
puts "Final order: #{letters}"
results << letters

# Part 2: Dance 1,000,000,000 times (including the first time)

# 100.times do |i|
#   if letters == ('a'..'p').to_a.join
#     puts "complete loop in #{i} iterations"
#     exit
#   end
# end

# Process loops after 29 iterations.
# 1,000,000,000 % 29 is 18.  So 1,000,000,000 iterations
# is the same as 18.  :P

9.times do
  instructions.each do |instruction|
    letters = Dance.read(instruction, letters)
  end
  results << letters
end
puts "After 1,000,000,000 times ;) : #{letters}"

#*.