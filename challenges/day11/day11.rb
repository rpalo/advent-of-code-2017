# frozen_string_literal: true

require_relative 'hexgrid'

steps = ARGF.read.chomp.split(",")
final_position = Hexgrid.final_position(steps)
puts "Distance from origin:", Hexgrid.distance(final_position)
puts "Final position", final_position
puts "Maximum distance away", Hexgrid.max_distance(steps)
