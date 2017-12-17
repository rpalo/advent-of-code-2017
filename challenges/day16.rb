# frozen_string_literal: true

require_relative '../lib/dance'

letters = ('a'..'p').to_a.join
instructions = ARGF.read.chomp.split(',')
instructions.each do |instruction|
  letters = Dance.read(instruction, letters)
end
puts "Final order: #{letters}"