# frozen_string_literal: true

require_relative 'memory'

banks = ARGF.read.split.map(&:to_i)
mem = Memory.new(banks)

# Part 1:
puts "Cycles to loop:", mem.cycles_to_loop

mem = Memory.new(banks)
# Part 2:
puts "Length of loop", mem.size_of_loop

#+
