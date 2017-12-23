# frozen_string_literal: true

require_relative '../lib/coprocessor'

instructions = ARGF.read.chomp
co = Coprocessor.new
co.process(instructions)
puts "After instructions, mul was called #{co.calls[:mul]} times"
co.reset
co.registers["a"] = 1
co.optimize_for_h
puts "After running, value in H is #{co.registers['h']}"

#M
