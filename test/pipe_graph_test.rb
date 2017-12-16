# frozen_string_literal: true

require 'test_helper'
require 'pipe_graph'

class TestPipeGraph < Minitest::Test
  def setup
    connections = <<~HEREDOC
      0 <-> 2
      1 <-> 1
      2 <-> 0, 3, 4
      3 <-> 2, 4
      4 <-> 2, 3, 6
      5 <-> 6
      6 <-> 4, 5
    HEREDOC
    @g = PipeGraph.from_instructions(connections)
  end

  # Part 1: How big is the subgraph with 0
  def test_simple_graph
    assert_equal 6, @g.subgraph_with('0').size
  end

  # Part 2: How many subgraphs are there?
  def test_group_count
    assert_equal 2, @g.subgraphs.size
  end
end
