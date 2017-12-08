# frozen_string_literal: true

class Registry
  def initialize(instructions)
    @registers = Hash.new(0)
    instructions.each_line { |instruction| process(instruction) }
  end

  def process(instruction)
    target, action, amount, _, comp_item, comparison, comp_val = instruction.split
    if @registers[comp_item].send(comparison.to_sym, comp_val.to_i)
      multiplier = action == "inc" ? 1 : -1
      @registers[target] += multiplier * amount.to_i
    end
  end

  def max
    _, max_value = @registers.max_by { |name, value| value }
    max_value
  end
end
