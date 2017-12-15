# frozen_string_literal: true

require_relative 'number_generator'
require_relative 'number_judge'

a = NumberGenerator.new(512, 16_807)
b = NumberGenerator.new(191, 48_271)
j = NumberJudge.new(40_000_000, [a, b])
puts "Total score: #{j.score}"
