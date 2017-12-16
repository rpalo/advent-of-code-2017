# frozen_string_literal: true

class Registry
  attr_reader :max_during

  def initialize(instructions)
    @registers = Hash.new(0)
    @max_during = 0
    instructions.each_line { |instruction| process(instruction) }
  end

  def process(instruction)
    target, action, amount, _, comp_item, comparison, comp_val = instruction.split
    if @registers[comp_item].send(comparison.to_sym, comp_val.to_i)
      multiplier = action == "inc" ? 1 : -1
      @registers[target] += multiplier * amount.to_i
    end
    current_max = max || 0  # Could return nil if no registers initialized
    @max_during = current_max if current_max > @max_during
  end

  # Part 1: Provide max value at end
  def max
    _, max_value = @registers.max_by { |name, value| value }
    max_value
  end
end
