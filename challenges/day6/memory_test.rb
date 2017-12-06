# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'memory'

class TestMemory < Minitest::Test
  # Part 1: Cycles of redistribution before a duplicate state
  def test_provided_example
    m = Memory.new([0, 2, 7, 0])
    assert_equal 5, m.cycles_to_loop
  end

  # Part 2: How long is the cycle between duplicate states?
  def test_provided_cycle_length_example
    m = Memory.new([0, 2, 7, 0])
    assert_equal 4, m.size_of_loop
  end
end
