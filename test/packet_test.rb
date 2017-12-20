# frozen_string_literal: true

require 'test_helper'
require 'packet'

# Test cases for Packet
class TestPacket < Minitest::Test
  def setup
    @packet_map = <<~HEREDOC
          |          
          |  +--+    
          A  |  C    
      F---|----E|--+ 
          |  |  |  D 
          +B-+  +--+ 
    HEREDOC
    @p = Packet.new
  end

  def test_part_1
    @p.travel(@packet_map)
    assert_equal %w(A B C D E F), @p.history
  end

  def test_part_2
    @p.travel(@packet_map)
    assert_equal 38, @p.steps
  end
end
