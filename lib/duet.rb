# frozen_string_literal: true

# Music making class
class Duet
  def initialize
    @registers = Hash.new(0)
    @last_send = nil
    @current = 0
  end

  def read_to_recover(instructions)
    lines = instructions.lines.map(&:split)
    while @current >= 0 && @current < lines.size
      command, reg, value = lines[@current]
      value = if /[a-z]+/.match?(value)
                @registers[value]
              else
                value.to_i
              end
      result = send(command, reg, value.to_i)

      return result if command == "rcv" && result

      @current += 1 unless command == "jgz" && result
    end
  end

  def set(reg, value)
    @registers[reg] = value
    nil
  end

  def add(reg, value)
    @registers[reg] += value
    nil
  end

  def mul(reg, value)
    @registers[reg] *= value
    nil
  end

  def mod(reg, value)
    @registers[reg] %= value
    nil
  end

  def snd(reg, *_rest)
    @last_send = @registers[reg]
    nil
  end

  def rcv(reg, *_rest)
    @registers[reg].positive? ? @last_send : nil
  end

  def jgz(reg, step_size)
    @current += step_size if @registers[reg].positive?
  end

  def [](item)
    @registers[item]
  end
end
