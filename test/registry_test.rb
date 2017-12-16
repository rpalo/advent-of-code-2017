# frozen_string_literal: true

require 'test_helper'
require 'registry'

class TestRegistry < Minitest::Test
  def setup
    instructions = <<~HEREDOC
      b inc 5 if a > 1
      a inc 1 if b < 5
      c dec -10 if a >= 1
      c inc -20 if c == 10
    HEREDOC
    @r = Registry.new(instructions)
  end

  # Part 1: Max value at end
  def test_small_example
    assert_equal 1, @r.max
  end

  # Part 2: Max value through the whole process
  def test_max_value_during
    assert_equal 10, @r.max_during
  end
end
