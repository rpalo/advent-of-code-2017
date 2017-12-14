# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'firewall'

# Test cases for Firewall
class TestFirewall < Minitest::Test
  def test_simple
    instructions = <<~HEREDOC
      0: 3
      1: 2
      4: 4
      6: 4
    HEREDOC
    f = Firewall.new(instructions)
    assert_equal 24, f.packet_severity
  end
end
