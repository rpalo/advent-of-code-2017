# frozen_string_literal: true

# A layer in a firewall
class Layer
  def initialize(depth, range)
    @depth = depth
    @range = range
    @slots = Array.new(range)
    @scanner = 0
    @direction = -1
  end

  def severity
    @depth * @range
  end

  def caught?
    @scanner.zero?
  end

  def tick
    return if @range < 2
    @direction *= -1 if @scanner.zero? or @scanner == @range - 1
    @scanner += @direction
  end
end