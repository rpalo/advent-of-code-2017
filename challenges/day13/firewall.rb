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

  def packet_severity
    packet = -1
    severity = 0
    while packet < @layers.size
      packet += 1
      unless @layers[packet].nil?
        severity += @layers[packet].severity if @layers[packet].caught?
      end
      @layers.each(&:tick)
    end
    severity
  end
end
