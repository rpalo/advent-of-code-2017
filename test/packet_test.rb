# frozen_string_literal: true

require 'test_helper'
require 'packet'

# Test cases for Packet
class TestPacket < Minitest::Test
  def test_part_1
    packet_map = <<~HEREDOC
          |          
          |  +--+    
          A  |  C    
      F---|----E|--+ 
          |  |  |  D 
          +B-+  +--+ 
    HEREDOC
    p = Packet.new
    p.travel(packet_map)
    assert_equal %w(A B C D E F), p.history
  end
end
