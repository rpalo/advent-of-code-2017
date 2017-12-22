# frozen_string_literal: true

require_relative '../lib/virus'

grid = ARGF.read.chomp
vi = Virus.new(grid)
vi.cycle(10_000)
puts "After 10k cycles, infected #{vi.infections} times"
