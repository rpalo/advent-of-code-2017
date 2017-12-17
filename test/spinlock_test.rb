# frozen_string_literal: true

require 'test_helper'
require 'spinlock'

# Test cases for Spinlock
class TestSpinlock < Minitest::Test
  def test_part_1
    s = Spinlock.new
    s.spin(3, 2017)
    assert_equal 638, s[s.current + 1]
  end
end
