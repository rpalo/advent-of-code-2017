# frozen-string_literal: true

require 'minitest/autorun'
require_relative 'knot_hash'

# Test cases for the knot hash
class TestKnotHash < Minitest::Test
  # Part 1: Twist the lengths according to specified algorithm
  def test_small_knot
    knot = KnotHash.new(4)
    input_lengths = [3, 4, 1, 5]
    knot.twist(*input_lengths)
    assert_equal 12, knot[0] * knot[1]
  end

  # Part 2: Follow algorithm to get hash string
  def test_hash_empty_string
    knot = KnotHash.new
    assert_equal "a2582a3a0e66e6e86e3812dcb672a272", knot.hash('')
  end

  def test_hash_fun_string
    knot = KnotHash.new
    assert_equal "33efeb34ea91902bb2f59c9920caa6cd", knot.hash('AoC 2017')
  end

  def test_hash_1_2_3
    knot = KnotHash.new
    assert_equal "3efbe78a8d82f29979031a4aa0b16a9d", knot.hash('1,2,3')
  end

  def test_hash_1_2_4
    knot = KnotHash.new
    assert_equal "63960835bcdc130f0b66d7ff4f6a5a8e", knot.hash('1,2,4')
  end

  # Utility functions
  def test_compress_with_simple_input
    knot = KnotHash.new(4)
    result = knot.compress([123, 2, 3, 4,
                            5, 6, 7, 8,
                            9, 10, 11, 12,
                            13, 14, 15, 16])
    assert_equal [106], result
  end

  def test_hex_with_simple_input
    knot = KnotHash.new(4)
    assert_equal "01020318", knot.hex([1, 2, 3, 24])
  end
end
