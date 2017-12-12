# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'pipe_graph'

class TestPipeGraph < Minitest::Test
  def test_simple_graph
    connections = <<~HEREDOC
      0 <-> 2
      1 <-> 1
      2 <-> 0, 3, 4
      3 <-> 2, 4
      4 <-> 2, 3, 6
      5 <-> 6
      6 <-> 4, 5
    HEREDOC
    g = PipeGraph.from_instructions(connections)
    assert_equal 6, g.subgraph_with('0').size
  end
end
