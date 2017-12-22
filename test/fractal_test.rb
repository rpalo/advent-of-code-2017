# frozen_string_literal: true

require 'test_helper'
require 'fractal'

# Test cases for Fractal
class TestFractal < Minitest::Test
  def test_part_1
    start = <<~HEREDOC
      .#.
      ..#
      ###
    HEREDOC
    rules = <<~HEREDOC
      ../.# => ##./#../...
      .#./..#/### => #..#/..../..../#..#
    HEREDOC
    f = Fractal.new(start, rules)
    f.iterate(2)
    assert_equal 12, f.on
  end
end
