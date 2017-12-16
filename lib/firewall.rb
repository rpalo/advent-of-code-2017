# frozen_string_literal: true

require_relative 'layer'

# A firewall to scan packets passing through
# The layer caught? calculation allows us to ignore blank layers
class Firewall
  MAXIMUM_DELAY = 1_000_000_000

  def initialize(build_instructions)
    @layers = []
    build_instructions.each_line do |line|
      depth, range = line.scan(/[0-9]+/).map(&:to_i)
      @layers << Layer.new(depth, range)
    end
  end

  # Part 1: What is severity with delay = 0
  def packet_severity
    @layers.reduce(0) do |total, layer|
      total + (layer.caught? ? layer.severity : 0)
    end
  end

  # Part 2: What is smallest delay with severity = 0
  def optimal_delay
    (0..MAXIMUM_DELAY).each do |delay|
      return delay unless caught?(delay)
    end
    raise "Delay exceeded max bound"
  end

  def caught?(delay = 0)
    @layers.any? do |layer|
      layer.caught?(delay)
    end
  end
end
