# frozen-string_literal: true

require 'minitest/autorun'
require_relative 'knot_hash'

class TestKnotHash < Minitest::Test

  def test_small_knot
    knot = KnotHash.new(4)
    input_lengths = [3, 4, 1, 5]
    knot.twist(*input_lengths)
    assert_equal 12, knot[0] * knot[1]
  end
end
