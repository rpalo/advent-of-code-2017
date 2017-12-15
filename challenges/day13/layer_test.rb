# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'layer'

class TestLayer < Minitest::Test
  def test_caught_true_when_scanner_on_zero
    l = Layer.new(8, 5)
    assert l.caught?
  end

  def test_not_caught_when_scanner_off_zero
    l = Layer.new(8, 6)
    refute l.caught?
  end

  def test_delay_offsets_by_one_each_time
    l = Layer.new(2, 2) # Should get caught every other one
    assert l.caught?
    refute l.caught?(1)
    assert l.caught?(2)
    refute l.caught?(3)
    assert l.caught?(4)
  end
end
