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
      command, reg, value = lines[@current]
      value = if /[a-z]+/.match?(value)
                @registers[value]
              else
                value.to_i
              end
      state = send(command, reg, value)
      @current += 1 unless [:jump, :receive].include?(state.status)
      return state if [:send, :receive].include?(state.status)
    end
    @waiting = true
    State.new(nil, :continue)
  end

  def set(reg, value)
    @registers[reg] = value
    State.new(nil, :continue)
  end

  def add(reg, value)
    @registers[reg] += value
    State.new(nil, :continue)
  end

  def mul(reg, value)
    @registers[reg] *= value
    State.new(nil, :continue)
  end

  def mod(reg, value)
    @registers[reg] %= value
    State.new(nil, :continue)
  end

  def snd(reg, *_rest)
    @sent += 1
    if /[a-z]+/.match?(reg)
      retval = @registers[reg]
    else
      retval = reg.to_i
    end
    State.new(retval, :send)
  end

  def rcv(reg, *_rest)
    if @queue.empty?
      @waiting = true
      State.new(nil, :receive)
    else
      @waiting = false
      @registers[reg] = @queue.shift
      State.new(nil, :continue)
    end
  end

  def jgz(reg, step_size)
    if /[a-z]+/.match?(reg)
      item = @registers[reg]
    else
      item = reg.to_i
    end
    if item.positive?
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

  def [](item)
    @registers[item]
  end
end
