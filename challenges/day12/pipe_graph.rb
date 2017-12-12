# frozen_string_literal: true

require 'set'

class PipeGraph
  attr_reader :vertices, :edges

  def initialize(edges, vertices)
    @edges = edges
    @vertices = vertices
  end
  
  def self.from_instructions(instructions)
    edges, vertices = process(instructions)
    PipeGraph.new(edges, vertices)
  end

  def self.process(instructions)
    edges = Set.new
    vertices = Set.new
    instructions.each_line do |line|
      node, connection_string = line.scan(/([0-9]+) <-> ([0-9, ]+)/).first
      connections = connection_string.split(', ')
      vertices << node
      connections.each { |conn| edges << Set.new([node, conn]) }
    end
    [edges, vertices]
  end

  def neighbors(node)
    edges = @edges.dup.select! { |edge| edge.include?(node) }
    vertices = edges.flatten - [node]
    [edges, vertices]
  end


  # Part 1: How big is the subgraph containing '0'
  # Essentially generated by a breadth first search
  def subgraph_with(vertex)
    vertices = Set.new
    edges = Set.new
    pending = [vertex]
    until pending.empty?
      this_node = pending.shift
      conn_edges, conn_nodes = neighbors(this_node)
      conn_nodes.each do |node|
        pending << node unless vertices.include?(node)
      end
      vertices << this_node
      edges << conn_edges
    end
    PipeGraph.new(edges, vertices)
  end

  # Part 2: How many subgraphs are there?
  def subgraphs
    subs = []
    nodes_to_hit = @vertices.dup
    until nodes_to_hit.empty?
      subgraph = subgraph_with(nodes_to_hit.to_a.first)
      subs << subgraph
      nodes_to_hit -= subgraph.vertices
    end
    subs
  end

  def size
    @vertices.size
  end
end
