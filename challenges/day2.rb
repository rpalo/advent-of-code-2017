# frozen_string_literal: true

require_relative '../lib/spreadsheet'

num_string = ARGF.read
sheet = Spreadsheet.new(num_string)
puts sheet.divisible_sum

#      +
