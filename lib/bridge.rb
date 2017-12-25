# frozen_string_literal: true

require_relative 'connector'

# Magnetic bridge with multiple connectors
class Bridge

  def initialize(connector_text)
    connectors = connector_text.lines.reduce([]) do |acc, curr|
      this_conn = Connector.new(curr.split("/").map(&:to_i))
      acc + [this_conn]
    end
    @bridges = build_bridges(connectors)
  end

  def build_bridges(available, open_val = 0, current = [])

    possible_children = available.select { |conn| conn.ports.include?(open_val) }
    return current if possible_children.empty?
    bridges = []
    possible_children.each do |child|
      recursed_value = build_bridges(
        available - [child],
        child.besides(open_val),
        current + [child]
      )
      if recursed_value[0].class == Connector
        bridges << recursed_value
      else
        bridges += recursed_value
      end
    end
    bridges
  end

  def strongest_score(bridges = @bridges)
    bridge_scores = bridges.map do |bridge|
      bridge.reduce(0) { |total, conn| total + conn.ports.sum }
    end
    bridge_scores.max
  end

  def longest_bridges
    lengths = @bridges.map(&:size)
    longest = lengths.max
    @bridges.select { |bridge| bridge.size == longest }
  end

  def longest_strongest
    longest = longest_bridges
    strongest_score(longest)
  end
end
