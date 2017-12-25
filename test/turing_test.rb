# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/turing'

# Test cases for Turing
class TestTuring < Minitest::Test
  def test_part_1
    blueprint = <<~HEREDOC
      Begin in state A.
      Perform a diagnostic checksum after 6 steps.

      In state A:
        If the current value is 0:
          - Write the value 1.
          - Move one slot to the right.
          - Continue with state B.
        If the current value is 1:
          - Write the value 0.
          - Move one slot to the left.
          - Continue with state B.

      In state B:
        If the current value is 0:
          - Write the value 1.
          - Move one slot to the left.
          - Continue with state A.
        If the current value is 1:
          - Write the value 1.
          - Move one slot to the right.
          - Continue with state A.
    HEREDOC
    t = Turing.new(blueprint)
    assert_equal 3, t.checksum
  end
end
