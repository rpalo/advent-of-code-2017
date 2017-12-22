# frozen_string_literal: true

require_relative '../lib/fractal'

start = <<~HEREDOC
  .#.
  ..#
  ###
HEREDOC
rules = ARGF.read.chomp
frac = Fractal.new(start, rules)
frac.iterate(5)
puts "# of cells on after 5 iterations: #{frac.on}"
frac.iterate(13)
puts "# of cells on after 18 iterations: #{frac.on}"

#Y
