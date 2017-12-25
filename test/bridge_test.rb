# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/bridge'

# Test cases for Bridge
class TestBridge < Minitest::Test
  def test_part_1
    segments = <<~HEREDOC
      0/2
      2/2
      2/3
      3/4
      3/5
      0/1
      10/1
      9/10
    HEREDOC
    b = Bridge.new(segments)
    assert_equal 31, b.strongest_score
  end
end
