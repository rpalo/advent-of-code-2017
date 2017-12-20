# frozen_string_literal: true

# Music making class
class Solo
  attr_reader :waiting, :sent, :queue, :current

  State = Struct.new(:value, :status)
  # Status can be :continue, :receive, :send, :jump

  def initialize(num)
    @id_no = num
    @registers = Hash.new(num)
    @queue = []
    @current = 0
    @waiting = false
    @sent = 0
  end

  def read(instructions)
    lines = instructions.lines.map(&:split)
    while (0...lines.size).include?(@current)
      command, arg1, arg2 = lines[@current]
      state = send(command, arg1, arg2)
      @current += 1 unless [:jump, :receive].include?(state.status)
      return state if [:send, :receive].include?(state.status)
    end
    @waiting = true
    State.new(nil, :continue)
  end

  def set(arg1, arg2)
    reg, value = allow_inputs([arg1, arg2], [:register, :either])
    @registers[reg] = value
    State.new(nil, :continue)
  end

  def add(arg1, arg2)
    reg, value = allow_inputs([arg1, arg2], [:register, :either])
    @registers[reg] += value
    State.new(nil, :continue)
  end

  def mul(arg1, arg2)
    reg, value = allow_inputs([arg1, arg2], [:register, :either])
    @registers[reg] *= value
    State.new(nil, :continue)
  end

  def mod(arg1, arg2)
    reg, value = allow_inputs([arg1, arg2], [:register, :either])
    @registers[reg] %= value
    State.new(nil, :continue)
  end

  def snd(arg1, arg2 = nil)
    value, _ = allow_inputs([arg1, arg2], [:either, :none])
    @sent += 1
    State.new(value, :send)
  end

  def rcv(arg1, arg2 = nil)
    reg, _ = allow_inputs([arg1, arg2], [:register, :none])
    if @queue.empty?
      @waiting = true
      State.new(nil, :receive)
    else
      @waiting = false
      @registers[reg] = @queue.shift
      State.new(nil, :continue)
    end
  end

  def jgz(arg1, arg2)
    value, step_size = allow_inputs([arg1, arg2], [:either, :either])
    if value.positive?
      @current += step_size
      State.new(nil, :jump)
    else
      State.new(nil, :continue)
    end
  end

  def enqueue(value)
    @queue << value
    @waiting = false
  end

  def allow_inputs(arguments, possibles)
    arguments.zip(possibles).map do |arg, type|
      case type
      when :register
        arg
      when :number
        arg.to_i
      when :either
        if /[a-z]+/.match?(arg.to_s)
          @registers[arg]
        else
          arg.to_i
        end
      when :none
        nil
      else
        raise "Argument acceptance type #{type} not recognized"
      end
    end
  end

  def [](item)
    @registers[item]
  end
end
