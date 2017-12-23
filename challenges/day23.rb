# frozen_string_literal: true

require_relative '../lib/coprocessor'

instructions = ARGF.read.chomp
co = Coprocessor.new
co.process(instructions)
puts "After instructions, mul was called #{co.calls[:mul]} times"
