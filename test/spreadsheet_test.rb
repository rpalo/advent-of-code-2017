# frozen_string_literal: true

# Test cases for Spreadsheet checksum puzzles on day 2
require 'test_helper'
require 'spreadsheet'

# Test cases for Spreadsheet class
class TestSpreadsheet < Minitest::Test
  def test_checksum_on_provided_example
    cells = <<~HEREDOC
      5 1 9 5
      7 5 3
      2 4 6 8
    HEREDOC
    sheet = Spreadsheet.new(cells)
    assert_equal 18, sheet.checksum
  end

  def test_checksum_on_simple_spreadsheet
    cells = <<~HEREDOC
      1 5
      5 1
    HEREDOC
    sheet = Spreadsheet.new(cells)
    assert_equal 8, sheet.checksum
  end

  def test_divisible_sum_on_provided_example
    cells = <<~HEREDOC
      5 9 2 8
      9 4 7 3
      3 8 6 5
    HEREDOC
    sheet = Spreadsheet.new(cells)
    assert_equal 9, sheet.divisible_sum
  end

  def test_divisible_sum_on_simple_example
    cells = <<~HEREDOC
      2 4
      4 2
    HEREDOC
    sheet = Spreadsheet.new(cells)
    assert_equal 4, sheet.divisible_sum
  end
end
