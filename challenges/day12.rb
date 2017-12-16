# frozen_string_literal: true

## My algorithm is noticably slow with large inputs.
## Seems like there's some room to improve.

require_relative '../lib/pipe_graph'

connections = ARGF.read.chomp
graph = PipeGraph.from_instructions(connections)
puts "Size of graph connected to 0", graph.subgraph_with('0').size
puts "Number of subgraphs", graph.subgraphs.size

#+
