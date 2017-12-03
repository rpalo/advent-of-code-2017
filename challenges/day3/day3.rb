# frozen_string_literal: true

require_relative 'spiral'

number = ARGV[0].to_i

puts Spiral::manhattan_distance(number)
