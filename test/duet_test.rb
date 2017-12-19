# frozen_string_literal: true

require 'test_helper'
require 'duet'

# Test cases for Duet
class TestDuet < Minitest::Test
  def test_part_2
    instructions = <<~HEREDOC
      snd 1
      snd 2
      snd p
      rcv a
      rcv b
      rcv c
      rcv d
    HEREDOC
    d = Duet.new(instructions)
    assert_equal 3, d.count_communications(1)
  end
end
