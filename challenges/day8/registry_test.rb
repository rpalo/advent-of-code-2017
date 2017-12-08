# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/color'
require_relative 'registry'

class TestRegistry < Minitest::Test
  def test_small_example
    instructions = <<~HEREDOC
      b inc 5 if a > 1
      a inc 1 if b < 5
      c dec -10 if a >= 1
      c inc -20 if c == 10
    HEREDOC
    r = Registry.new(instructions)
    assert_equal 1, r.max
  end
end
