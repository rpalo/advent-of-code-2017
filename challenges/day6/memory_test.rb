# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'memory'

class TestMemory < Minitest::Test
  def test_provided_example
    m = Memory.new([0, 2, 7, 0])
    assert_equal 5, m.cycles_to_loop
  end
end
