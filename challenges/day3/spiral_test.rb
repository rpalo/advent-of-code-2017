require 'minitest/autorun'
require_relative 'spiral'

# Test class for Spiral calculations
class TestSpiral < Minitest::Test

  # Part 1: Manhattan Distance
  def test_one_is_in_the_center
    assert_equal 0, Spiral::manhattan_distance(1)
  end

  def test_12_is_down_left_left
    assert_equal 3, Spiral::manhattan_distance(12)
  end

  def test_23_is_two_steps_up
    assert_equal 2, Spiral::manhattan_distance(23)
  end

  def test_1024_is_a_long_way_away
    assert_equal 31, Spiral::manhattan_distance(1024)
  end
end
