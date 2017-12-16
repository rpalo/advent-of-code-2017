# frozen_string_literal: true

require_relative '../lib/spiral'

number = ARGV[0].to_i

puts "Part 1:", Spiral.manhattan_distance(number)
puts "Part 2:", Spiral.cumulative_spiral_number(number)

#+
