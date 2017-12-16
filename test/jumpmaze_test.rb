# frozen_string_literal: true

require 'test_helper'
require 'jumpmaze'

# Test cases for Jump Maze
class TestJumpMaze < Minitest::Test
  def test_with_provided_sample
    j = JumpMaze.new([0, 3, 0, 1, -3])
    assert_equal 5, j.steps_to_escape
  end

  def test_with_longer_maze
    maze = [1, 1, 1, 1, 1, 1, 1, 1, 1, -9]
    j = JumpMaze.new(maze)
    assert_equal 15, j.steps_to_escape
  end
end