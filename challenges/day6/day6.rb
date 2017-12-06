# frozen_string_literal: true

require_relative 'memory'

banks = ARGF.read.split.map(&:to_i)
mem = Memory.new(banks)
puts "Cycles to loop:", mem.cycles_to_loop
