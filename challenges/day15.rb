# frozen_string_literal: true

require_relative '../lib/number_generator'
require_relative '../lib/number_judge'

a = NumberGenerator.new(512, 16_807, 4)
b = NumberGenerator.new(191, 48_271, 8)

# Part 1: Raw score
# j = NumberJudge.new(40_000_000, [a, b])
# puts "Total score: #{j.score}"

# Part 2: Picky Score
j2 = NumberJudge.new(5_000_000, [a, b])
puts "Picky score: #{j2.score(picky = true)}"

#+
