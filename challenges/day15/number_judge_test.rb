# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'number_generator'
require_relative 'number_judge'

# Test cases for Number Judge
class TestNumberJudge < Minitest::Test
  def setup
    @a = NumberGenerator.new(65, 16_807)
    @b = NumberGenerator.new(8921, 48_271)
  end

  def test_part_1
    j = NumberJudge.new(40_000_000, [@a, @b])
    assert_equal 588, j.score
  end

  def test_lowest_bits
    j = NumberJudge.new(10, [nil, nil])
    assert_equal '0000000000000001', j.lowest_bits(1, 16)
  end
end
