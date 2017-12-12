# frozen_string_literal: true

require_relative 'pipe_graph'

connections = ARGF.read.chomp
graph = PipeGraph.from_instructions(connections)
puts "Size of graph connected to 0", graph.subgraph_with('0').size
