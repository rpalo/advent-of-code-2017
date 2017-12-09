# frozen_string_literal: true

require_relative 'registry'
instructions = ARGF.read
reg = Registry.new(instructions)

# Part 1: Max after processing
puts "Max register:", reg.max

# Part 2: Max throughout process
puts "Max during:", reg.max_during

#*
