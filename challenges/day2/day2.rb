require_relative 'spreadsheet'

num_string = ARGF.read
sheet = Spreadsheet.new(num_string)
puts sheet.divisible_sum