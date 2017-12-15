# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'number_generator'

# Test cases for NumberGenerator
class TestNumberGenerator < Minitest::Test
  def test_generator_creates_next_number
    a = NumberGenerator.new(65, 16_807, 4)
    assert_equal 1_092_455, a.next
  end

  def test_generator_creates_first_five
    a = NumberGenerator.new(65, 16_807, 4)
    expected = [
      1_092_455,
      1_181_022_009,
      245_556_042,
      1_744_312_007,
      1_352_636_452,
    ]
    assert_equal expected, a.first(5)
  end
end
