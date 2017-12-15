# frozen_string_literal: true

require_relative 'firewall'

instructions = ARGF.read.chomp
wall = Firewall.new(instructions)
puts "Severity:", wall.packet_severity
wall.reset
puts "Optimal delay time:", wall.optimal_delay
