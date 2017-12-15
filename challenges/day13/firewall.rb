# frozen_string_literal: true

require_relative 'layer'

# A firewall to scan packets passing through
class Firewall
  def initialize(build_instructions)
    @layers = []
    build_instructions.each_line do |line|
      depth, range = line.scan(/[0-9]+/).map(&:to_i)
      until @layers.size >= depth
        @layers << Layer.new(@layers.size, 0)
      end
      @layers << Layer.new(depth, range)
    end
  end

  # Part 1: What is severity with delay = 0
  def packet_severity
    @layers.reduce(0) do |total, layer|
      result = total + (layer.caught? ? layer.severity : 0)
      tick
      result
    end
  end

  # Part 2: What is smallest delay with severity = 0
  def optimal_delay
    delay = 0
    while delay < 10000
      reset
      return delay unless caught?(delay)
      delay += 1
    end
    raise "Delay exceeded max bound"
  end

  def caught?(delay = 0)
    tick(delay)
    @layers.any? do |layer|
      return true if layer.caught?
      tick
      false
    end
  end

  def tick(count = 1)
    count.times { @layers.each(&:tick) }
  end

  def reset
    @layers.each do |layer|
      layer.scanner = 0
      layer.direction = -1
    end
  end
end
