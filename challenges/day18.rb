# frozen_string_literal: true

require_relative '../lib/duet'

instructions = ARGF.read.chomp
d = Duet.new
puts "First value to be recovered: #{d.read_to_recover(instructions)}"
