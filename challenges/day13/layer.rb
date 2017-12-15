# frozen_string_literal: true

# A layer in a firewall
class Layer
  attr_accessor :scanner, :direction

  def initialize(depth, range)
    @depth = depth
    @range = range
  end

  def severity
    @depth * @range
  end

  def caught?(delay = 0)
    return true if @range == 1
    # Delaying is essentially like incrementing each layer's depth by 1
    # Each scanner will take n - 1 steps down and n - 1 steps back.
    # Thus, it will be on zero (divide evenly into depth) every 2*(n-1) steps
    value = ((@depth + delay) % ((@range - 1) * 2))
    value.zero?
  end
end
