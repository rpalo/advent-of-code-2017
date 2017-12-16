# frozen_string_literal: true

require_relative '../lib/knot_hash'

bytes = ARGF.read.chomp
lengths = bytes.split(',').map(&:to_i)

# Part 1: twist the lengths provided
knot = KnotHash.new
knot.twist(*lengths)
puts "Result of multiplication", knot[0] * knot[1]

# Part 2: Hash the input as characters
knot = KnotHash.new
puts "Hash of input", knot.hash(bytes)

#    +
