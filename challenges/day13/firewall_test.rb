# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'firewall'

# Test cases for Firewall
class TestFirewall < Minitest::Test
  def setup
    instructions = <<~HEREDOC
      0: 3
      1: 2
      4: 4
      6: 4
    HEREDOC
    @f = Firewall.new(instructions)
  end
  # Part 1: Calculate severity with delay = 0
  def test_simple

    assert_equal 24, @f.packet_severity
  end

  # Part 2: Find smallest delay for severity = 0
  def test_simple_with_delay
    assert_equal 10, @f.optimal_delay
  end
end
