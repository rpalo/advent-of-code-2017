# frozen_string_literal: true

require 'test_helper'
require 'crazymaze'

# Test cases for Part 2 Crazymaze
class TestCrazyMaze < Minitest::Test
  def test_provided_example
    c = CrazyMaze.new([0, 3, 0, 1, -3])
    assert_equal 10, c.steps_to_escape
  end

  def test_longer_example
    maze = [3, 1, 1, 1, 1, 1, 1, 1, -8]
    c = CrazyMaze.new(maze)
    assert_equal 12, c.steps_to_escape
  end
end