# frozen_string_literal: true

require_relative 'state'

# Simulates a tape/register/state turing machine
class Turing
  def initialize(blueprint)
    @tape = Array.new(10, 0)
    @current = 5
    @states, @current_state, @diagnostic = analyze(blueprint)
  end

  def analyze(blueprint)
    states = {}
    start_state = nil
    diagnostic = 0
    new_state = nil
    new_if_val = nil
    blueprint.lines.each do |line|
      case line
      when /^Begin in state ([A-Z])/
        start_state = $1.to_sym
      when /checksum after ([0-9]+)/
        diagnostic = $1.to_i
      when /^In state ([A-Z]):/
        new_state = State.new($1.to_sym)
        states[new_state.name] = new_state
      when /current value is ([01]):/
        new_if_val = $1.to_i
      when /Write the value ([01])./
        new_state.set_write(new_if_val, $1.to_i)
      when /Move one slot to the right./
        new_state.set_move(new_if_val, 1)
      when /Move one slot to the left./
        new_state.set_move(new_if_val, -1)
      when /Continue with state ([A-Z])/
        new_state.set_next(new_if_val, $1.to_sym)
      end
    end
    [states, start_state, diagnostic]
  end

  def checksum
    @diagnostic.times do
      this_state = @states[@current_state]
      this_tape_val = @tape[@current]
      this_action = this_state.action(this_tape_val)

      @tape[@current] = this_action.write_val
      @current += this_action.move_val
      grow_tape_if_needed
      @current_state = this_action.next_state
    end
    @tape.sum
  end

  def grow_tape_if_needed
    if @current.negative?
      pad_size = @tape.size
      @tape = Array.new(pad_size, 0) + @tape
      @current += pad_size
    elsif @current >= @tape.size
      @tape += Array.new(@tape.size, 0)
    end
  end
end
