# frozen_string_literal: true

# Magnetic bridge connectors
class Connector
  attr_accessor :ports
  def initialize(ports)
    @ports = ports
  end

  def besides(num)
    if @ports.first == num
      @ports.last
    else
      @ports.first
    end
  end

  def ==(other)
    @ports == other.ports
  end
end
