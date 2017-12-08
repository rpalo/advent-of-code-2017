# frozen_string_literal: true

require_relative 'registry'
instructions = ARGF.read
reg = Registry.new(instructions)
puts "Max register:", reg.max
