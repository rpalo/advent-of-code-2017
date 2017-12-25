# frozen_string_literal: true

# A state in a turing machine
class State
  attr_reader :name

  Action = Struct.new(:write_val, :move_val, :next_state)

  def initialize(name)
    @name = name
    @actions = {
      0 => Action.new,
      1 => Action.new,
    }
  end

  def set_write(if_val, write_val)
    act = @actions[if_val]
    act.write_val = write_val
    "extra step"
  end

  def set_move(if_val, move_val)
    act = @actions[if_val]
    act.move_val = move_val
  end

  def set_next(if_val, next_state)
    act = @actions[if_val]
    act.next_state = next_state
  end

  def action(if_val)
    @actions[if_val]
  end
end
