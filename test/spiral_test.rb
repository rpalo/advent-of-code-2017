# frozen_string_literal: true

require 'test_helper'
require 'spiral'

# Test class for Spiral calculations
class TestSpiral < Minitest::Test
  # Part 1: Manhattan Distance
  def test_one_is_in_the_center
    assert_equal 0, Spiral.manhattan_distance(1)
  end

  def test_12_is_down_left_left
    assert_equal 3, Spiral.manhattan_distance(12)
  end

  def test_23_is_two_steps_up
    assert_equal 2, Spiral.manhattan_distance(23)
  end

  def test_1024_is_a_long_way_away
    assert_equal 31, Spiral.manhattan_distance(1024)
  end

  # Part 2: Cumulative spiral

  # Tests for add_neighbors
  def test_adding_neighbors_from_left_corner
    grid = [
      [1],
      [2, 2, 2],
      [3, 3, 3],
    ]
    assert_equal 4, Spiral.add_neighbors(grid, 0)
  end

  def test_adding_neighbors_from_middle
    grid = [
      [1, 2],
      [2, 2, 2],
      [3, 3, 3],
    ]
    assert_equal 7, Spiral.add_neighbors(grid, 1)
  end

  def test_adding_neighbors_from_right_corner
    grid = [
      [1, 2, 3],
      [2, 2, 2],
      [3, 3, 3],
    ]
    assert_equal 6, Spiral.add_neighbors(grid, 2)
  end

  # Tests for rotate_ccw
  def test_rotate_ccw_on_tiny_grid
    grid = [
      [1],
    ]
    assert_equal grid, Spiral.rotate_ccw(grid)
  end

  def test_rotate_ccw_on_good_size_grid
    grid = [
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 10, 11, 12],
    ]
    expected = [
      [4, 8, 12],
      [3, 7, 11],
      [2, 6, 10],
      [1, 5, 9],
    ]
    assert_equal expected, Spiral.rotate_ccw(grid)
  end

  # Tests for add_layer
  def test_add_layer_to_one_element
    grid = [
      [1],
    ]
    expected = [
      [0, 0, 0],
      [0, 1, 0],
      [0, 0, 0],
    ]
    assert_equal expected, Spiral.add_layer(grid)
  end

  def test_add_layer_to_larger_grid
    grid = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ]
    expected = [
      [0, 0, 0, 0, 0],
      [0, 1, 2, 3, 0],
      [0, 4, 5, 6, 0],
      [0, 7, 8, 9, 0],
      [0, 0, 0, 0, 0],
    ]
    assert_equal expected, Spiral.add_layer(grid)
  end

  # Tests for cumulative spiral
  def test_cumulative_spiral_at_small_num
    assert_equal 4, Spiral.cumulative_spiral_number(3)
  end

  def test_cumulative_spiral_at_medium_num
    assert_equal 133, Spiral.cumulative_spiral_number(125)
  end

  def test_cumulative_spiral_at_large_num
    assert_equal 806, Spiral.cumulative_spiral_number(750)
  end
end
