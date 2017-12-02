# Test cases for Spreadsheet checksum puzzles on day 2
require 'minitest/autorun'
require_relative 'spreadsheet'

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
end