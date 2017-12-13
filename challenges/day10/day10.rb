# frozen_string_literal: true

require_relative 'knot_hash'

lengths = ARGF.read.chomp.split(',').map(&:to_i)
knot = KnotHash.new(255)
knot.twist(*lengths)
puts "Result of multiplication", knot[0] * knot[1]
